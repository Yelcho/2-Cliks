FUNCTION y2c_get_workitem_details.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(USER) TYPE  SYUNAME DEFAULT SY-UNAME
*"     VALUE(LANGUAGE) TYPE  SYLANGU DEFAULT SY-LANGU
*"  EXPORTING
*"     VALUE(WORKITEM_ATTRIBUTES) TYPE  SWR_WIHDR
*"     VALUE(DECISION_TITLE) TYPE  SWR_WIHDR-WI_TEXT
*"  TABLES
*"      OBJECTS_2 STRUCTURE  SWR_OBJ_2
*"      ALTERNATIVES STRUCTURE  SWR_DECIALTS
*"      RECIPIENTS STRUCTURE  SWRAGENT
*"  EXCEPTIONS
*"      WORKITEM_NOT_FOUND
*"----------------------------------------------------------------------
  DATA: return_code TYPE sy-subrc.

***********************
* Get workitem header *
***********************
  CALL FUNCTION 'Y2C_WAPI_GET_HEADER'
    EXPORTING
      workitem_id         = workitem_id
      user                = user
      language            = language
    IMPORTING
      workitem_attributes = workitem_attributes
      return_code         = return_code.

    IF workitem_attributes IS INITIAL.
      raise workitem_not_found.
    ENDIF.

************************
* Get workitem objects *
************************
    CALL FUNCTION 'Y2C_WAPI_GET_OBJECTS'
      EXPORTING
        workitem_id           = workitem_attributes-wi_id
      TABLES
        objects_2             = objects_2.

************************
* Get decision details *
************************
    CALL FUNCTION 'Y2C_WAPI_DECISION_READ'
      EXPORTING
        workitem_id           = workitem_attributes-wi_id
      IMPORTING
        return_code           = return_code
        decision_title        = decision_title
      TABLES
        alternatives          = alternatives.

******************
* Get recipients *
******************
    CALL FUNCTION 'Y2C_WAPI_WORKITEM_RECIPIENTS'
      EXPORTING
        workitem_id           = workitem_attributes-wi_id
      IMPORTING
        return_code           = return_code
      TABLES
        recipients            = recipients.

ENDFUNCTION.
