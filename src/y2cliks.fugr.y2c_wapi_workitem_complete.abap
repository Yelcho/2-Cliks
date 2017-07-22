FUNCTION y2c_wapi_workitem_complete.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) LIKE  SWR_STRUCT-WORKITEMID
*"     VALUE(ACTUAL_AGENT) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"     VALUE(SET_OBSOLET) TYPE  XFELD DEFAULT SPACE
*"     VALUE(DO_COMMIT) TYPE  XFELD DEFAULT 'X'
*"     VALUE(DO_CALLBACK_IN_BACKGROUND) TYPE  XFELD DEFAULT 'X'
*"     VALUE(IFS_XML_CONTAINER) TYPE  XSTRING OPTIONAL
*"  EXPORTING
*"     VALUE(RETURN_CODE) LIKE  SY-SUBRC
*"     VALUE(NEW_STATUS) TYPE  SWW_WISTAT
*"  TABLES
*"      SIMPLE_CONTAINER STRUCTURE  SWR_CONT OPTIONAL
*"      MESSAGE_LINES STRUCTURE  SWR_MESSAG OPTIONAL
*"      MESSAGE_STRUCT STRUCTURE  SWR_MSTRUC OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'SAP_WAPI_WORKITEM_COMPLETE'
    EXPORTING
      workitem_id               = workitem_id
      actual_agent              = actual_agent
      language                  = language
      set_obsolet               = set_obsolet
      do_commit                 = do_commit
      do_callback_in_background = do_callback_in_background
      ifs_xml_container         = ifs_xml_container
    IMPORTING
      return_code               = return_code
      new_status                = new_status
    TABLES
      simple_container          = simple_container
      message_lines             = message_lines
      message_struct            = message_struct.

ENDFUNCTION.
