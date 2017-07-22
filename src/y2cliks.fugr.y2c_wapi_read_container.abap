FUNCTION y2c_wapi_read_container.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"     VALUE(IFS_XML_CONTAINER) TYPE  XSTRING
*"     VALUE(IFS_XML_CONTAINER_SCHEMA) TYPE  XSTRING
*"  TABLES
*"      SIMPLE_CONTAINER STRUCTURE  SWR_CONT OPTIONAL
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"      SUBCONTAINER_BOR_OBJECTS STRUCTURE  SWR_CONT OPTIONAL
*"      SUBCONTAINER_ALL_OBJECTS STRUCTURE  SWR_CONT OPTIONAL
*"--------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_READ_CONTAINER'
    EXPORTING
      workitem_id              = workitem_id
      language                 = language
      user                     = user
    IMPORTING
      return_code              = return_code
      ifs_xml_container        = ifs_xml_container
      ifs_xml_container_schema = ifs_xml_container_schema
    TABLES
      simple_container         = simple_container
      message_lines            = message_lines
      message_struct           = message_struct
      subcontainer_bor_objects = subcontainer_bor_objects
      subcontainer_all_objects = subcontainer_all_objects.

ENDFUNCTION.
