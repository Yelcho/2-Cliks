FUNCTION y2c_wapi_get_header.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"  EXPORTING
*"     VALUE(WORKITEM_ATTRIBUTES) TYPE  SWR_WIHDR
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"  TABLES
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"--------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_GET_HEADER'
    EXPORTING
      workitem_id         = workitem_id
      user                = user
      language            = language
    IMPORTING
      workitem_attributes = workitem_attributes
      return_code         = return_code
    TABLES
      message_lines       = message_lines
      message_struct      = message_struct.

ENDFUNCTION.
