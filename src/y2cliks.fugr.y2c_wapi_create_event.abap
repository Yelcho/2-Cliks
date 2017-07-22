FUNCTION y2c_wapi_create_event.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(OBJECT_TYPE) TYPE  SWR_STRUCT-OBJECT_TYP
*"     VALUE(OBJECT_KEY) TYPE  SWR_STRUCT-OBJECT_KEY
*"     VALUE(EVENT) TYPE  SWR_STRUCT-EVENT
*"     VALUE(COMMIT_WORK) TYPE  SWR_STRUCT-COMMITFLAG DEFAULT 'X'
*"     VALUE(EVENT_LANGUAGE) TYPE  SY-LANGU DEFAULT SY-LANGU
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(IFS_XML_CONTAINER) TYPE  XSTRING OPTIONAL
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"     VALUE(EVENT_ID) TYPE  SWR_STRUCT-EVENT_ID
*"  TABLES
*"      INPUT_CONTAINER STRUCTURE  SWR_CONT OPTIONAL
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_CREATE_EVENT'
    EXPORTING
      object_type       = object_type
      object_key        = object_key
      event             = event
      commit_work       = commit_work
      event_language    = event_language
      language          = language
      user              = user
      ifs_xml_container = ifs_xml_container
    IMPORTING
      return_code       = return_code
      event_id          = event_id
    TABLES
      input_container   = input_container
      message_lines     = message_lines
      message_struct    = message_struct.

ENDFUNCTION.
