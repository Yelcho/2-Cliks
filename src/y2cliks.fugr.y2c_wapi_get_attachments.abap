FUNCTION y2c_wapi_get_attachments.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"  TABLES
*"      ATTACHMENTS STRUCTURE  SWR_OBJECT OPTIONAL
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_GET_ATTACHMENTS'
    EXPORTING
      workitem_id    = workitem_id
      user           = user
      language       = language
    IMPORTING
      return_code    = return_code
    TABLES
      attachments    = attachments
      message_lines  = message_lines
      message_struct = message_struct.

ENDFUNCTION.
