FUNCTION y2c_document_read_api1 .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(DOCUMENT_ID) TYPE  SOFOLENTI1-DOC_ID
*"     VALUE(FILTER) TYPE  SOFILTERI1 DEFAULT 'X '
*"  EXPORTING
*"     VALUE(DOCUMENT_DATA) TYPE  SOFOLENTI1
*"  TABLES
*"      OBJECT_HEADER STRUCTURE  SOLISTI1 OPTIONAL
*"      OBJECT_CONTENT STRUCTURE  SOLISTI1 OPTIONAL
*"      OBJECT_PARA STRUCTURE  SOPARAI1 OPTIONAL
*"      OBJECT_PARB STRUCTURE  SOPARBI1 OPTIONAL
*"      ATTACHMENT_LIST STRUCTURE  SOATTLSTI1 OPTIONAL
*"      RECEIVER_LIST STRUCTURE  SORECLSTI1 OPTIONAL
*"      CONTENTS_HEX STRUCTURE  SOLIX OPTIONAL
*"  EXCEPTIONS
*"      DOCUMENT_ID_NOT_EXIST
*"      OPERATION_NO_AUTHORIZATION
*"      X_ERROR
*"----------------------------------------------------------------------

  CALL FUNCTION 'SO_DOCUMENT_READ_API1'
    EXPORTING
      document_id                = document_id
      "filter                     = 'X '
    IMPORTING
      document_data              = document_data
    TABLES
      object_header              = object_header
      object_content             = object_content
      object_para                = object_para
      object_parb                = object_parb
      attachment_list            = attachment_list
      receiver_list              = receiver_list
      contents_hex               = contents_hex
    EXCEPTIONS
      document_id_not_exist      = 1
      operation_no_authorization = 2
      x_error                    = 3
      OTHERS                     = 4.

  CASE sy-subrc.
    WHEN 1.
      RAISE document_id_not_exist.
    WHEN 2.
      RAISE operation_no_authorization.
    WHEN 3.
      RAISE x_error.
    WHEN OTHERS.
  ENDCASE.

ENDFUNCTION.
