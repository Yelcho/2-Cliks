FUNCTION y2c_wapi_get_objects.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(BUFFERED_ACCESS) TYPE  XFELD DEFAULT 'X'
*"  EXPORTING
*"     VALUE(LEADING_OBJECT) TYPE  SWR_OBJECT
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"     VALUE(LEADING_OBJECT_2) TYPE  SWR_OBJ_2
*"  TABLES
*"      OBJECTS STRUCTURE  SWR_OBJECT OPTIONAL
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"      OBJECTS_2 STRUCTURE  SWR_OBJ_2 OPTIONAL
*"--------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_GET_OBJECTS'
    EXPORTING
      workitem_id      = workitem_id
      language         = language
      user             = user
      "buffered_access  = buffered_access
    IMPORTING
      leading_object   = leading_object
      return_code      = return_code
      leading_object_2 = leading_object_2
    TABLES
      objects          = objects
      message_lines    = message_lines
      message_struct   = message_struct
      objects_2        = objects_2.

ENDFUNCTION.
