FUNCTION y2c_wapi_substitutes_get.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(SUBSTITUTED_OBJECT) TYPE  SWRAGENT
*"     VALUE(START_DATE) TYPE  SYDATUM DEFAULT SY-DATUM
*"     VALUE(END_DATE) TYPE  SYDATUM DEFAULT '99991231'
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SYSUBRC
*"  TABLES
*"      SUBSTITUTES STRUCTURE  SWR_SUBSTITUTE OPTIONAL
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_SUBSTITUTES_GET'
    EXPORTING
      substituted_object = substituted_object
      start_date         = start_date
      end_date           = end_date
      language           = language
    IMPORTING
      return_code        = return_code
    TABLES
      substitutes        = substitutes
      message_lines      = message_lines
      message_struct     = message_struct.

ENDFUNCTION.
