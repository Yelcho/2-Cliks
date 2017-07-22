FUNCTION y2c_wapi_set_workitem_status.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(STATUS) TYPE  SWR_WISTAT-STATUS
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(DO_COMMIT) TYPE  XFELD DEFAULT 'X'
*"  EXPORTING
*"     VALUE(NEW_STATUS) TYPE  SWR_WISTAT
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"  TABLES
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_SET_WORKITEM_STATUS'
    EXPORTING
      workitem_id    = workitem_id
      status         = status
      user           = user
      language       = language
      do_commit      = do_commit
    IMPORTING
      new_status     = new_status
      return_code    = return_code
    TABLES
      message_lines  = message_lines
      message_struct = message_struct.

ENDFUNCTION.
