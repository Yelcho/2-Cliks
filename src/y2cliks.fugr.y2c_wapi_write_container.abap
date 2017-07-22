FUNCTION y2c_wapi_write_container.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(ACTUAL_AGENT) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(DO_COMMIT) TYPE  XFELD DEFAULT 'X'
*"     VALUE(IFS_XML_CONTAINER) TYPE  XSTRING OPTIONAL
*"     VALUE(OVERWRITE_TABLES_SIMPLE_CONT) TYPE  XFELD DEFAULT SPACE
*"  EXPORTING
*"     VALUE(RETURN_CODE) TYPE  SY-SUBRC
*"  TABLES
*"      SIMPLE_CONTAINER STRUCTURE  SWR_CONT OPTIONAL
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_WRITE_CONTAINER'
    EXPORTING
      workitem_id                  = workitem_id
      language                     = language
      actual_agent                 = actual_agent
      do_commit                    = do_commit
      ifs_xml_container            = ifs_xml_container
      overwrite_tables_simple_cont = overwrite_tables_simple_cont
    IMPORTING
      return_code                  = return_code
    TABLES
      simple_container             = simple_container
      message_lines                = message_lines
      message_struct               = message_struct.

ENDFUNCTION.
