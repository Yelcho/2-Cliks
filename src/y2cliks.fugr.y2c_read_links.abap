FUNCTION y2c_read_links.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_OBJECT) TYPE  SIBFLPORB
*"     VALUE(IS_LOGSYS) TYPE  LOGSYS OPTIONAL
*"  EXPORTING
*"     VALUE(ET_LINKS) TYPE  OBL_T_LINK
*"     VALUE(ET_ROLES) TYPE  OBL_T_ROLE
*"--------------------------------------------------------------------

  DATA:
          lt_relation_options TYPE  obl_t_relt,
          lr_relation_option TYPE REF TO obl_s_relt.

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

ENDFUNCTION.
