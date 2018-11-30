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

  IF document_id NS '|'.
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

  ELSE. " SAP ArchiveLink Document
    CALL FUNCTION 'Y2C_GET_ALINK_DOC_DATA'
      EXPORTING
        document_id           = document_id
      IMPORTING
        document_data         = document_data
      EXCEPTIONS
        document_id_not_exist = 1
        OTHERS                = 2.
    IF sy-subrc <> 0.
      RAISE document_id_not_exist.
    ENDIF.

    DATA archiv_id       TYPE toaar-archiv_id.
    DATA document_type   TYPE toadd-doc_type.
    DATA archiv_doc_id   TYPE sapb-sapadokid.
    DATA binlength       TYPE sapb-length.
    DATA binarchivobject TYPE STANDARD TABLE OF tbl1024.

    SPLIT document_id AT '|' INTO archiv_id archiv_doc_id.

    CALL FUNCTION 'ARCHIVOBJECT_GET_TABLE'
      EXPORTING
        archiv_id                = archiv_id
        document_type            = 'ATTACH' "document_type
        archiv_doc_id            = archiv_doc_id
      IMPORTING
        binlength                = binlength
      TABLES
        binarchivobject          = binarchivobject
      EXCEPTIONS
        error_archiv             = 1
        error_communicationtable = 2
        error_kernel             = 3
        OTHERS                   = 4.
    IF sy-subrc <> 0.
      RAISE x_error.
    ENDIF.

*--------------------------------------------------------------------*
* Transpose 1024 byte table type to 255 byte                         *
*--------------------------------------------------------------------*
    DATA: line_1024    TYPE tbl1024,
          line_content TYPE xstring,
          line_255     TYPE solix,
          abs_char     TYPE i,
          act_char     TYPE i.

    LOOP AT binarchivobject INTO line_1024.
      IF sy-tabix = 1.
        line_content =  line_1024-line.
      ELSE.
        CONCATENATE line_content line_1024-line INTO line_content IN BYTE MODE .
      ENDIF.
    ENDLOOP.

    abs_char  = xstrlen( line_content ).

    DO.
      MOVE line_content TO line_255-line.
      APPEND line_255 TO contents_hex.
      SHIFT line_content LEFT BY 255 PLACES IN BYTE MODE .
      CLEAR line_255.
      act_char = act_char + 255.
      IF act_char > abs_char.
        EXIT.
      ENDIF.
    ENDDO.

  ENDIF.

ENDFUNCTION.
