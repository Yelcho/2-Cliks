FUNCTION y2c_get_email_body.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WORKITEM_ID) TYPE  SWR_STRUCT-WORKITEMID
*"     VALUE(LANGUAGE) TYPE  SWR_STRUCT-WILANGUAGE DEFAULT SY-LANGU
*"  EXPORTING
*"     VALUE(HTML_DATA) TYPE  STRING
*"----------------------------------------------------------------------
*--------------------------------------------------------------------------------*
* Simple example to show how to formulate HTML payload for insertion in 2-Cliks  *
* email from workitem details.                                                   *
*                                                                                *
* This example simply reads the workitem container and renders the contents in a *
* HTML table. For BOR based workflows the workitem container usually contains    *
* the key fields of the underlying business document that you can then use to    *
* obtain extensive details required to support the decision step.                *
*                                                                                *
* You can also use this single function module as the entry point for many       *
* different workflow types if you so desire.                                     *
*                                                                                *
* Note the use of inline CSS styles - this is because many email clients do not  *
* support internal or external CSS styling.                                      *
*                                                                                *
*--------------------------------------------------------------------------------*

  DATA: lt_container TYPE        swrtcont,
        lr_swr_cont  TYPE REF TO swr_cont,
        lv_value     TYPE        char50.

  CALL FUNCTION 'SAP_WAPI_READ_CONTAINER'
    EXPORTING
      workitem_id      = workitem_id
      language         = language
    TABLES
      simple_container = lt_container.

  LOOP AT lt_container REFERENCE INTO lr_swr_cont.
    IF lr_swr_cont->value IS NOT INITIAL.
      lv_value = lr_swr_cont->value.
    ELSE.
      lv_value = '&nbsp;'.
    ENDIF.
*----------------------------------------------------------------------*
* Note that in contemporary versions of ABAP you could replace         *
* the concatenate statements with much simpler alternatives            *
* by using string templates like this...                               *
*                                                                      *
* html_data = html_data &&                                             *
*   |<tr><td>{ lr_swr_cont->element }</td><td>{ lv_value }</td></tr>|. *
*----------------------------------------------------------------------*
    CONCATENATE
      html_data
      '<tr><td>'
      lr_swr_cont->element
      `</td><td>`
      lv_value
      '</td></tr>'
      INTO html_data.
  ENDLOOP.

  CONCATENATE
    `<div align="center">`
    `<div style="border:1px solid #FAD42E;`
    `background: #FBEC88 50% 50% repeat-x;`
    `-moz-border-radius:5px;-webkit-border-radius:5px;`
    `margin:10px;`
    `color:gray;white-space:nowrap;`
    `width:auto">`
    `This is the contents of the workflow item container.<p>`
    `It is a simple task to replace this area of the email with all the details<p>`
    `the recipient requires to make a decision for this workflow.`
    `<br />`
    `<table id="container" style="border: 1px solid gray;background:#CCC;`
    `-moz-border-radius:5px;-webkit-border-radius:5px">`
    `<thead>`
    `<tr><th colspan="2">Workitem Container</th></tr>`
    `<tr><th>Element</th><th>Value</th></tr>`
    `</thead><tbody>`
    html_data
    `</tbody></table>`
    `</div>`
    `</div>`
  INTO html_data.

ENDFUNCTION.
