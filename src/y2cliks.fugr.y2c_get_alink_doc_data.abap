FUNCTION y2c_get_alink_doc_data .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(DOCUMENT_ID) TYPE  SOFOLENTI1-DOC_ID
*"  EXPORTING
*"     VALUE(DOCUMENT_DATA) TYPE  SOFOLENTI1
*"  EXCEPTIONS
*"      DOCUMENT_ID_NOT_EXIST
*"----------------------------------------------------------------------

  DATA archiv_doc_id        TYPE sapb-sapadokid.
  DATA archiv_id            TYPE toaar-archiv_id.
  DATA archiv_object_status TYPE sapb-sapdokstat.
  DATA ar_date              TYPE sapb-sapabldate.
  DATA ar_time              TYPE sapb-sapablzeit.
  DATA document_type        TYPE sapb-sapdoktyp.
  DATA al_components        TYPE STANDARD TABLE OF components.
  DATA al_component         TYPE REF TO components.
  DATA compsl               TYPE STANDARD TABLE OF scms_compsl.
  DATA connections        TYPE STANDARD TABLE OF toav0.
  DATA connection         TYPE REF TO toav0.

  SPLIT document_id AT '|' INTO archiv_id archiv_doc_id.

  CALL FUNCTION 'ARCHIVOBJECT_STATUS'
    EXPORTING
      archiv_doc_id            = archiv_doc_id
      archiv_id                = archiv_id
    IMPORTING
      archiv_object_status     = archiv_object_status
      ar_date                  = ar_date
      ar_time                  = ar_time
      document_type            = document_type
    TABLES
      al_components            = al_components
      compsl                   = compsl
    EXCEPTIONS
      error_archiv             = 1
      error_communicationtable = 2
      error_kernel             = 3
      OTHERS                   = 4.
  IF sy-subrc <> 0.
    RAISE document_id_not_exist.
  ENDIF.

  document_data-doc_id = document_id.
  document_data-object_id = archiv_doc_id.
  document_data-obj_type = document_type.
  document_data-obj_name = archiv_doc_id.
  document_data-obj_descr = document_id.

  CALL FUNCTION 'ARCHIV_GET_CONNECTIONS'
    EXPORTING
      archiv_id     = archiv_id
      arc_doc_id    = archiv_doc_id
    TABLES
      connections   = connections
    EXCEPTIONS
      nothing_found = 1
      OTHERS        = 2.
  IF sy-subrc = 0.
    LOOP AT connections REFERENCE INTO connection. ENDLOOP.
    SELECT SINGLE objecttext
      FROM toasp
      INTO document_data-obj_descr
      WHERE ar_object = connection->ar_object
      AND language = sy-langu.
  ENDIF.

  LOOP AT al_components REFERENCE INTO al_component.
    document_data-doc_size = document_data-doc_size + al_component->compsize.
  ENDLOOP.

ENDFUNCTION.
