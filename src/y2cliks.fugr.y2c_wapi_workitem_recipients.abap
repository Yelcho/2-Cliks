FUNCTION y2c_wapi_workitem_recipients.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"  TABLES
*"      RECIPIENTS STRUCTURE  SWRAGENT
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"      ORIGINAL_RULE_RESULT STRUCTURE  SWRAGENT OPTIONAL
*"--------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_WORKITEM_RECIPIENTS'
    EXPORTING
      workitem_id          = workitem_id
      language             = language
      user                 = user
    IMPORTING
      return_code          = return_code
    TABLES
      recipients           = recipients
      message_lines        = message_lines
      message_struct       = message_struct
      original_rule_result = original_rule_result.

ENDFUNCTION.
