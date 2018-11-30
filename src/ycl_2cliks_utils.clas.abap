class YCL_2CLIKS_UTILS definition
  public
  final
  create public .

public section.

  class-methods GET_GROSS_PRICE
    importing
      !CONDITIONS type BAPIMEPOCOND_TP
      !ITM_NUMBER type EBELP
    returning
      value(RV_GROSS_PRICE) type BAPIKAWRT1 .
  class-methods GET_WBS_NAME
    importing
      !POSID type PS_POSID
    returning
      value(RV_WBS) type STRING .
  class-methods GET_CC_NAME
    importing
      !KOKRS type KOKRS
      !KOSTL type KOSTL
    returning
      value(RV_CC) type STRING .
  class-methods GET_GL_ACC_NAME
    importing
      !KTOPL type KTOPL
      !SAKNR type SAKNR
    returning
      value(RV_GLACC) type STRING .
  class-methods GET_ORDER_NAME
    importing
      !KOKRS type KOKRS
      !AUFNR type AUFNR
    returning
      value(RV_ORDER) type STRING .
protected section.
private section.
ENDCLASS.



CLASS YCL_2CLIKS_UTILS IMPLEMENTATION.


METHOD get_cc_name.

  SELECT SINGLE ltext
    INTO rv_cc
    FROM cskt
    WHERE spras = sy-langu
    AND kokrs = kokrs
    AND kostl = kostl
    AND datbi > sy-datum.

  rv_cc = |{ kostl }-{ rv_cc }|.

  SHIFT rv_cc LEFT DELETING LEADING '0'.

ENDMETHOD.


METHOD get_gl_acc_name.

  SELECT SINGLE txt20
    INTO rv_glacc
    FROM skat
    WHERE spras = sy-langu
    AND ktopl = ktopl
    AND saknr = saknr.

  rv_glacc = |{ saknr }-{ rv_glacc }|.

  SHIFT rv_glacc LEFT DELETING LEADING '0'.

ENDMETHOD.


METHOD get_gross_price.

  DATA: lr_condition TYPE REF TO bapimepocond.

  LOOP AT conditions REFERENCE INTO lr_condition
    WHERE itm_number = itm_number.

    CASE lr_condition->cond_type.
      WHEN 'NAVS'.
        ADD lr_condition->conbaseval TO rv_gross_price.
      WHEN OTHERS.
    ENDCASE.

  ENDLOOP.

ENDMETHOD.


METHOD get_order_name.

  SELECT SINGLE ktext
    INTO rv_order
    FROM aufk
    WHERE kokrs = kokrs
      AND aufnr = aufnr.

  rv_order = |{ aufnr }-{ rv_order }|.

  SHIFT rv_order LEFT DELETING LEADING '0'.

ENDMETHOD.


METHOD get_wbs_name.

  SELECT SINGLE post1 FROM prps                             "#EC *
    INTO rv_wbs
    WHERE posid = posid.

  rv_wbs = |{ posid }-{ rv_wbs }|.

  SHIFT rv_wbs LEFT DELETING LEADING '0'.

ENDMETHOD.
ENDCLASS.
