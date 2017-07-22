FUNCTION y2c_get_system_info.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(RFCSI_EXPORT) TYPE  RFCSI
*"     VALUE(RFC_LOGIN_COMPLETE) TYPE  SY-DEBUG
*"     VALUE(DIALOG_USER_TYPE) TYPE  SY-DEBUG
*"     VALUE(CURRENT_RESOURCES) TYPE  SY-INDEX
*"     VALUE(MAXIMAL_RESOURCES) TYPE  SY-INDEX
*"     VALUE(RECOMMENDED_DELAY) TYPE  SY-INDEX
*"     VALUE(DEST_COMMUNICATION_MESSAGE) TYPE  CHAR120
*"     VALUE(DEST_SYSTEM_MESSAGE) TYPE  CHAR120
*"--------------------------------------------------------------------

  CALL FUNCTION 'RFC_GET_SYSTEM_INFO'
    EXPORTING
      destination                = `NONE`
    IMPORTING
      rfcsi_export               = rfcsi_export
      rfc_login_complete         = rfc_login_complete
      dialog_user_type           = dialog_user_type
      current_resources          = current_resources
      maximal_resources          = maximal_resources
      recommended_delay          = recommended_delay
      dest_communication_message = dest_communication_message
      dest_system_message        = dest_system_message
    EXCEPTIONS
      authority_not_available    = 1
      OTHERS                     = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
