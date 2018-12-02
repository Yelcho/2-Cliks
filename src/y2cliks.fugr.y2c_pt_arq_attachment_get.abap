FUNCTION y2c_pt_arq_attachment_get.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IM_REQUEST_ID) TYPE  SYSUUID_C
*"     VALUE(IM_VERSION_NO) TYPE  INT4 OPTIONAL
*"     VALUE(IM_DOCUMENT_TYPE) TYPE  SAEOBJART OPTIONAL
*"  EXPORTING
*"     VALUE(EX_HAS_ERRORS) TYPE  BOOLEAN
*"     VALUE(EX_MESSAGES) TYPE  BAPIRET2_TAB
*"     VALUE(ET_ATTACHMENTS) TYPE  Y2C_HRESS_T_PTARQ_ATT_INFO
*"     VALUE(EX_HAS_ATTACHMENT) TYPE  BOOLE_D
*"----------------------------------------------------------------------

  CONSTANTS func TYPE char30 VALUE 'PT_ARQ_ATTACHMENT_GET'.

  TRY.
      CALL FUNCTION func
        EXPORTING
          im_request_id     = im_request_id
          im_version_no     = im_version_no
          im_document_type  = im_document_type
        IMPORTING
          ex_has_errors     = ex_has_errors
          ex_messages       = ex_messages
          et_attachments    = et_attachments
          ex_has_attachment = ex_has_attachment.
    CATCH cx_sy_dyn_call_illegal_func.
  ENDTRY.

ENDFUNCTION.
