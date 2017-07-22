FUNCTION y2c_reset_buffer.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"----------------------------------------------------------------------

* Delete buffer

  CALL METHOD cl_bsp_server_side_cookie=>delete_server_cookie
    EXPORTING
      name                  = c_cookie_id
      application_name      = c_cookie_id
      application_namespace = c_cookie_id
      username              = c_cookie_id
      session_id            = c_cookie_id.

ENDFUNCTION.
