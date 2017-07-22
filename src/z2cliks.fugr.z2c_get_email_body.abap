FUNCTION z2c_get_email_body.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(LANGUAGE) TYPE  SWR_STRUCT-WILANGUAGE DEFAULT SY-LANGU
*"  EXPORTING
*"     VALUE(HTML_DATA) TYPE  STRING
*"--------------------------------------------------------------------

  DATA:
        lv_error_message  TYPE string,
        ls_wi_header      TYPE swr_wihdr,
        lv_ret_code       TYPE sy-subrc.

  CALL FUNCTION 'SAP_WAPI_GET_HEADER'
    EXPORTING
      workitem_id         = workitem_id
      language            = language
    IMPORTING
      workitem_attributes = ls_wi_header
      return_code         = lv_ret_code.

  CASE ls_wi_header-wi_rh_task.
    WHEN ''.
      lv_error_message = |Workitem { workitem_id } not found|.

*    WHEN 'TS90000002'. " Leave request
*      CALL FUNCTION 'Z2C_GET_EMAIL_BODY_LEAVE'
*        EXPORTING
*          workitem_id = workitem_id
*          language    = language
*        IMPORTING
*          html_data   = html_data.

    WHEN OTHERS. "Just dump out container contents
      CALL FUNCTION 'Y2C_GET_EMAIL_BODY'
        EXPORTING
          workitem_id = workitem_id
          language    = language
        IMPORTING
          html_data   = html_data.

  ENDCASE.

  html_data =
    |<!-- Start of email body -->{ html_data }<!-- End of email body -->|.

  CHECK lv_error_message IS NOT INITIAL.

  html_data =
    `<!-- Start of email body -->` &&
    `<div align="center">` &&
    `<span style="border:1px solid #cd0a0a;border-radius:4px;` &&
    `background:#fef1ec 50% 50% repeat-x;color:#cd0a0a;` &&
    `white-space:nowrap;width:auto">` &&
    lv_error_message &&
    `</span>` &&
    `</div>` &&
    `<!-- End of email body -->`.

ENDFUNCTION.
