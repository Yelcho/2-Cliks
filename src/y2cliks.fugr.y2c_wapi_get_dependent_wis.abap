FUNCTION y2c_wapi_get_dependent_wis.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) LIKE  SWR_STRUCT-WORKITEMID
*"     VALUE(DIRECT_DEPENDANTS_ONLY) TYPE  XFELD DEFAULT SPACE
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(TRANSLATE_WI_TEXT) TYPE  XFELD DEFAULT SPACE
*"  EXPORTING
*"     VALUE(RETURN_CODE) LIKE  SY-SUBRC
*"  TABLES
*"      ITEMS STRUCTURE  SWR_WIHDR
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_GET_DEPENDENT_WIS'
    EXPORTING
      workitem_id            = workitem_id
      direct_dependants_only = direct_dependants_only
      user                   = user
      language               = language
      translate_wi_text      = translate_wi_text
    IMPORTING
      return_code            = return_code
    TABLES
      items                  = items
      message_lines          = message_lines
      message_struct         = message_struct.

ENDFUNCTION.
