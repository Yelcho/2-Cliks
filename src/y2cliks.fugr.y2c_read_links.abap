FUNCTION y2c_read_links.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_OBJECT) TYPE  SIBFLPORB
*"     VALUE(IS_LOGSYS) TYPE  LOGSYS OPTIONAL
*"  EXPORTING
*"     VALUE(ET_LINKS) TYPE  OBL_T_LINK
*"     VALUE(ET_ROLES) TYPE  OBL_T_ROLE
*"----------------------------------------------------------------------

  DATA:
    lt_relation_options TYPE  obl_t_relt,
    lr_relation_option  TYPE REF TO obl_s_relt.

  APPEND INITIAL LINE TO lt_relation_options REFERENCE INTO lr_relation_option.
  lr_relation_option->sign = 'I'.
  lr_relation_option->option = 'CP'.
  lr_relation_option->low = '*'.

  TRY.
      CALL METHOD cl_binary_relation=>read_links
        EXPORTING
          ip_logsys           = is_logsys
          is_object           = is_object
          it_relation_options = lt_relation_options
        IMPORTING
          et_links            = et_links
          et_roles            = et_roles.
    CATCH cx_obl_parameter_error .
    CATCH cx_obl_internal_error .
    CATCH cx_obl_model_error .
  ENDTRY.

*--------------------------------------------------------------------*
* Look for any SAP Archivelink attachments
*--------------------------------------------------------------------*
  DATA: connect_info TYPE STANDARD TABLE OF toav0,
        object_id    TYPE sapb-sapobjid,
        sap_object   TYPE toaom-sap_object.
  MOVE is_object-instid TO object_id.
  MOVE is_object-objtype TO sap_object.
  CALL FUNCTION 'ARCHIV_CONNECTINFO_GET_META'
    EXPORTING
      object_id             = object_id
      sap_object            = sap_object
    TABLES
      connect_info          = connect_info
    EXCEPTIONS
      error_connectiontable = 1
      OTHERS                = 2.

  LOOP AT connect_info REFERENCE INTO DATA(connection).
    APPEND INITIAL LINE TO et_links REFERENCE INTO DATA(link).
    link->roletype_a = 'SAPALINK'.
    link->instid_a = connection->object_id.
    link->typeid_a = connection->sap_object.
    link->catid_a = is_object-catid.
    link->roletype_b = 'ATTACHMENT'.
    link->instid_b = |{ connection->archiv_id }\|{ connection->arc_doc_id }|.
    link->typeid_b = connection->ar_object.
    link->reltype = 'ATTA'.
  ENDLOOP.
ENDFUNCTION.
