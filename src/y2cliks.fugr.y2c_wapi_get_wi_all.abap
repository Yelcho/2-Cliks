FUNCTION y2c_wapi_get_wi_all.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(WITH_DEADLINES) TYPE  XFELD DEFAULT SPACE
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SYSUBRC
*"     VALUE(TIMESTAMP) TYPE  TIMESTAMPL
*"     VALUE(WORKITEMS_COUNT) TYPE  SYTABIX
*"  TABLES
*"      TASK_FILTER STRUCTURE  SWR_TASK OPTIONAL
*"      WORKLIST STRUCTURE  SWR_WIHDR OPTIONAL
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_GET_WI_ALL'
    EXPORTING
      language        = language
      with_deadlines  = with_deadlines
    IMPORTING
      return_code     = return_code
      timestamp       = timestamp
      workitems_count = workitems_count
    TABLES
      task_filter     = task_filter
      worklist        = worklist
      message_lines   = message_lines
      message_struct  = message_struct.


**************************************************************
* The following code filters the workitems list so we just   *
* return those records that have changed since the last run. *
*                                                            *
* Note that this code does not check for changes in the      *
* underlying business document. If that happens another way  *
* of handling this will need to be implemented.              *
*                                                            *
**************************************************************
  DATA: lr_workitem    TYPE REF TO   swr_wihdr,
        lt_wi_buffer   TYPE TABLE OF wi_buffer_type,
        lr_wi_buffer   TYPE REF TO   wi_buffer_type,
        lt_recipients  TYPE TABLE OF swragent,
        lr_recipient   TYPE REF TO   swragent,
        lt_recipients2 TYPE TABLE OF swragent,
        lr_recipient2  TYPE REF TO   swragent,
        lt_substitutes TYPE          swrtsubstitute,
        lr_substitute  TYPE REF TO   swr_substitute,
        lt_addsmtp     TYPE TABLE OF bapiadsmtp,
        ls_addsmtp     TYPE          bapiadsmtp,
        lv_changed     TYPE          boolean,
        xcookie        TYPE          xstring.

  CHECK worklist[] IS NOT INITIAL.

* Get buffer from server side cookie
  CALL METHOD cl_bsp_server_side_cookie=>get_server_cookie
    EXPORTING
      name                  = c_cookie_id
      application_name      = c_cookie_id
      application_namespace = c_cookie_id
      username              = c_cookie_id
      session_id            = c_cookie_id
      data_name             = c_cookie_id
    CHANGING
      data_value            = xcookie.

  IF xcookie IS NOT INITIAL.
    TRY.
        IMPORT cookie = lt_wi_buffer FROM DATA BUFFER xcookie.
      CATCH cx_root.
        CLEAR lt_wi_buffer.
    ENDTRY.
  ENDIF.

* Delete buffer records created prior to todays date
  DELETE lt_wi_buffer WHERE creation_date < sy-datum.

* For each workitem
  LOOP AT worklist REFERENCE INTO lr_workitem.
    CLEAR: lt_recipients, lv_changed.

* Get recipients
    CALL FUNCTION 'Y2C_WAPI_WORKITEM_RECIPIENTS'
      EXPORTING
        workitem_id = lr_workitem->wi_id
      TABLES
        recipients  = lt_recipients.
*    IF lt_recipients IS INITIAL.
*      APPEND INITIAL LINE TO lt_recipients REFERENCE INTO lr_recipient.
*      lr_recipient->otype = 'US'.
*    ENDIF.

* Get substitutes
    LOOP AT lt_recipients REFERENCE INTO lr_recipient.
      CALL FUNCTION 'Y2C_WAPI_SUBSTITUTES_GET'
        EXPORTING
          substituted_object = lr_recipient->*
        TABLES
          substitutes        = lt_substitutes.
      LOOP AT lt_substitutes REFERENCE INTO lr_substitute.
        CHECK lr_substitute->active EQ 'X'.
        CHECK lr_substitute->date_begin LE sy-datum.
        CHECK lr_substitute->date_end GE sy-datum.
        APPEND INITIAL LINE TO lt_recipients2 REFERENCE INTO lr_recipient2.
        lr_recipient2->otype = lr_substitute->otype.
        lr_recipient2->objid = lr_substitute->objid.
      ENDLOOP.
    ENDLOOP.
    APPEND LINES OF lt_recipients2 TO lt_recipients.

* Check for new/changed recipients
    LOOP AT lt_recipients REFERENCE INTO lr_recipient.
      CLEAR: lt_addsmtp, ls_addsmtp.

      READ TABLE lt_wi_buffer
        REFERENCE INTO lr_wi_buffer
        WITH KEY wi_id = lr_workitem->wi_id
        wi_aagent = lr_recipient->objid.

* New recipient
      IF sy-subrc NE 0.
        APPEND INITIAL LINE TO lt_wi_buffer REFERENCE INTO lr_wi_buffer.
        lr_wi_buffer->wi_id = lr_workitem->wi_id.
        lr_wi_buffer->wi_aagent = lr_recipient->objid.
        lv_changed = abap_true.
      ENDIF.

* Get recipient email address
      CALL FUNCTION 'Y2C_USER_GET_DETAIL'
        EXPORTING
          username = lr_wi_buffer->wi_aagent
        TABLES
          addsmtp  = lt_addsmtp.
      READ TABLE lt_addsmtp INDEX 1 INTO ls_addsmtp.

* Check for new email address or status change
      IF ls_addsmtp-e_mail NE lr_wi_buffer->email
        OR lr_workitem->wi_stat NE lr_wi_buffer->wi_stat.
        lr_wi_buffer->wi_stat       = lr_workitem->wi_stat.
        lr_wi_buffer->email         = ls_addsmtp-e_mail.
        lr_wi_buffer->creation_date = sy-datum.
        lr_wi_buffer->creation_time = sy-uzeit.
        lv_changed                  = abap_true.
      ENDIF.
    ENDLOOP.

* Remove records from buffer that no longer exist
    LOOP AT lt_wi_buffer
        REFERENCE INTO lr_wi_buffer
        WHERE wi_id = lr_workitem->wi_id.
      READ TABLE lt_recipients
        REFERENCE INTO lr_recipient
        WITH KEY objid = lr_wi_buffer->wi_aagent.
      CHECK sy-subrc NE 0.
      DELETE lt_wi_buffer.
      lv_changed = abap_true.
    ENDLOOP.

* Delete worklist records that have not changed since last run
    CHECK lv_changed NE abap_true.
    DELETE worklist.
  ENDLOOP.

* Compress and save buffer to server side cookie
  EXPORT cookie = lt_wi_buffer TO DATA BUFFER xcookie.
  CALL METHOD cl_bsp_server_side_cookie=>set_server_cookie
    EXPORTING
      name                  = c_cookie_id
      application_name      = c_cookie_id
      application_namespace = c_cookie_id
      username              = c_cookie_id
      session_id            = c_cookie_id
      data_name             = c_cookie_id
      data_value            = xcookie
      expiry_date_rel       = 1.

ENDFUNCTION.
