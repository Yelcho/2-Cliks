FUNCTION y2c_wapi_forward_workitem.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(USER_ID) TYPE  SY-UNAME OPTIONAL
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(DO_COMMIT) TYPE  XFELD DEFAULT 'X'
*"     VALUE(CURRENT_USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"     VALUE(NEW_STATUS) TYPE  SWR_WISTAT
*"  TABLES
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"      USER_IDS STRUCTURE  SWRAGENT OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_FORWARD_WORKITEM'
    EXPORTING
      workitem_id    = workitem_id
      user_id        = user_id
      language       = language
      do_commit      = do_commit
      current_user   = current_user
    IMPORTING
      return_code    = return_code
      new_status     = new_status
    TABLES
      message_lines  = message_lines
      message_struct = message_struct
      user_ids       = user_ids.

ENDFUNCTION.
