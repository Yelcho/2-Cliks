FUNCTION y2c_wapi_decision_complete.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(LANGUAGE) TYPE  SWR_STRUCT-WILANGUAGE DEFAULT SY-LANGU
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(DECISION_KEY) TYPE  SWR_DECIKEY
*"     VALUE(DO_COMMIT) TYPE  XFELD DEFAULT 'X'
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"     VALUE(NEW_STATUS) TYPE  SWW_WISTAT
*"  TABLES
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"--------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_DECISION_COMPLETE'
    EXPORTING
      workitem_id    = workitem_id
      language       = language
      user           = user
      decision_key   = decision_key
      do_commit      = do_commit
    IMPORTING
      return_code    = return_code
      new_status     = new_status
    TABLES
      message_lines  = message_lines
      message_struct = message_struct.

ENDFUNCTION.
