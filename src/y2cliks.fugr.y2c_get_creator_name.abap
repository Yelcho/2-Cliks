FUNCTION y2c_get_creator_name.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"  EXPORTING
*"     VALUE(CREATOR_NAME) TYPE  STRING
*"--------------------------------------------------------------------

  DATA: lv_workitem  TYPE swr_struct-workitemid,
        ls_wi_header TYPE swr_wihdr,
        lv_username  TYPE uname,
        ls_address   TYPE bapiaddr3,
        lt_return    TYPE bapiret2_tab.

  MOVE workitem_id TO ls_wi_header-wi_chckwi.

  WHILE ls_wi_header-wi_chckwi IS NOT INITIAL.
    MOVE ls_wi_header-wi_chckwi TO lv_workitem.

    CALL FUNCTION 'SAP_WAPI_GET_HEADER'
      EXPORTING
        workitem_id         = lv_workitem
      IMPORTING
        workitem_attributes = ls_wi_header.

  ENDWHILE.

  IF ls_wi_header-wi_creator(2) = 'US'.
    MOVE ls_wi_header-wi_creator+2 TO lv_username.
    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username = lv_username
      IMPORTING
        address  = ls_address
      TABLES
        return   = lt_return.
    IF ls_address-fullname IS INITIAL.
      ls_address-fullname = lv_username.
    ENDIF.
  ELSE.
    ls_address-fullname = ls_wi_header-wi_creator.
  ENDIF.

  creator_name = ls_address-fullname.

ENDFUNCTION.
