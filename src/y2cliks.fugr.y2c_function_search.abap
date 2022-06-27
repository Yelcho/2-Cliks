FUNCTION y2c_function_search.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(FUNCNAME) TYPE  RS38L-NAME
*"     VALUE(GROUPNAME) TYPE  RS38L-AREA DEFAULT SPACE
*"     VALUE(LANGUAGE) TYPE  SY-LANGU DEFAULT SY-LANGU
*"  TABLES
*"      FUNCTIONS STRUCTURE  RFCFUNC
*"  EXCEPTIONS
*"      NOTHING_SPECIFIED
*"      NO_FUNCTION_FOUND
*"      OTHER
*"----------------------------------------------------------------------

  CALL FUNCTION 'RFC_FUNCTION_SEARCH'
    EXPORTING
      funcname          = funcname
      groupname         = groupname
      language          = language
    TABLES
      functions         = functions
    EXCEPTIONS
      nothing_specified = 1
      no_function_found = 2
      OTHERS            = 3.

  CASE sy-subrc.
    WHEN 0.
    WHEN 1.
      RAISE nothing_specified.
    WHEN 2.
      RAISE no_function_found.
    WHEN OTHERS.
      RAISE other.
  ENDCASE.

ENDFUNCTION.
