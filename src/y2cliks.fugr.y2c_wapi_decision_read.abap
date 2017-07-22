FUNCTION y2c_wapi_decision_read.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(LANGUAGE) TYPE  SWR_STRUCT-WILANGUAGE DEFAULT SY-LANGU
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SYSUBRC
*"     VALUE(DECISION_TITLE) TYPE  SWR_WIHDR-WI_TEXT
*"  TABLES
*"      ALTERNATIVES STRUCTURE  SWR_DECIALTS
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"--------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_DECISION_READ'
    EXPORTING
      workitem_id    = workitem_id
      language       = language
      user           = user
    IMPORTING
      return_code    = return_code
      decision_title = decision_title
    TABLES
      alternatives   = alternatives
      message_lines  = message_lines
      message_struct = message_struct.

ENDFUNCTION.
