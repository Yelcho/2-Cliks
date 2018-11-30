FUNCTION y2c_get_doc_data .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(DOCUMENT_ID) TYPE  SOFOLENTI1-DOC_ID
*"  EXPORTING
*"     VALUE(DOCUMENT_DATA) TYPE  SOFOLENTI1
*"  EXCEPTIONS
*"      DOCUMENT_ID_NOT_EXIST
*"----------------------------------------------------------------------

*--------------------------------------------------------------------*
* This FM is used to replace the standard SAP function module        *
* SO_DOCUMENT_READ_API1 when you just want to get minimum file       *
* details.                                                           *
*                                                                    *
* It is much faster because it does not attempt to retrieve the      *
* document contents.                                                 *
*--------------------------------------------------------------------*

  DATA: doc_key TYPE soentryi1,
        sood    TYPE sood.

  IF document_id NS '|'.
    MOVE document_id TO doc_key.

    SELECT SINGLE file_ext objtp objdes objlen FROM sood
      INTO CORRESPONDING FIELDS OF sood
      WHERE objtp = doc_key-objtp
      AND   objyr = doc_key-objyr
      AND   objno = doc_key-objno.

    IF sy-subrc = 0.
      document_data-doc_id = document_id.
      document_data-object_id = document_id+17.
      IF sood-file_ext IS NOT INITIAL.
        document_data-obj_type = sood-file_ext.
        TRANSLATE document_data-obj_type TO UPPER CASE.
      ELSE.
        document_data-obj_type = sood-objtp.
      ENDIF.
      document_data-obj_descr = sood-objdes.
      document_data-doc_size = sood-objlen.
    ELSE.
      RAISE document_id_not_exist.
    ENDIF.
  ELSE. " SAPArchiveLink attachment
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
  ENDIF.

ENDFUNCTION.
