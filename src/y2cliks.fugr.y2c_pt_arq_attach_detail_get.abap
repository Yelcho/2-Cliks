FUNCTION y2c_pt_arq_attach_detail_get.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_ARC_DOC_ID) TYPE  SAEARDOID
*"     VALUE(IV_DOC_TYPE) TYPE  SAEOBJART OPTIONAL
*"  EXPORTING
*"     VALUE(EX_FILE_CONTENT) TYPE  XSTRING
*"     VALUE(EX_HAS_ERRORS) TYPE  BOOLEAN
*"     VALUE(EX_MESSAGES) TYPE  BAPIRET2_TAB
*"----------------------------------------------------------------------

  CONSTANTS func TYPE char30 VALUE 'PT_ARQ_ATTACHMENT_DETAIL_GET'.
  TRY.
      CALL FUNCTION func
        EXPORTING
          iv_arc_doc_id   = iv_arc_doc_id
          iv_doc_type     = iv_doc_type
        IMPORTING
          ex_file_content = ex_file_content
          ex_has_errors   = ex_has_errors
          ex_messages     = ex_messages.
    CATCH cx_sy_dyn_call_illegal_func.
  ENDTRY.

ENDFUNCTION.
