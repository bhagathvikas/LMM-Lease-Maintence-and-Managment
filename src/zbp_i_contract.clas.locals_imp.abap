CLASS lhc_Contract DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Contract RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Contract RESULT result.

    METHODS ActivateContract FOR MODIFY
      IMPORTING keys FOR ACTION Contract~ActivateContract.

    METHODS GenerateInvoice FOR MODIFY
      IMPORTING keys FOR ACTION Contract~GenerateInvoice.

    METHODS DefaultValues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Contract~DefaultValues.

    METHODS CheckDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Contract~CheckDates.

ENDCLASS.

CLASS lhc_Contract IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ActivateContract.

  DATA(lt_keys) = keys.
    LOOP AT lt_keys INTO DATA(ls_key).
      DATA(lv_contractid) = ls_key-contractid.
      " update table
      UPDATE zlmm_contract SET status = 'ACTIVE' WHERE contractid = @lv_contractid.
    ENDLOOP.


  ENDMETHOD.

  METHOD GenerateInvoice.

  " For each key, create invoice header and one invoice item (simple)
    DATA(lt_keys) = keys.
    LOOP AT lt_keys INTO DATA(ls_key).
      DATA(lv_contractid) = ls_key-contractid.

      " fetch contract details
      SELECT SINGLE * FROM zlmm_contract  WHERE contractid = @lv_contractid INTO @DATA(ls_contract).
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      " Generate new invoice id - simple: 'INV' + timestamp
      DATA(lv_invid) = |INV{ sy-datum }{ sy-uzeit }|.
      lv_invid = lv_invid(20). "truncate to 20

      DATA(ls_hdr) = VALUE zlmm_inv_hdr(
        client       = sy-mandt
        invid        = lv_invid
        contractid   = lv_contractid
        tenantid     = ls_contract-tenantid
        invoice_date = cl_abap_context_info=>get_system_date( )
        period_from  = ls_contract-startdate
        period_to    = ls_contract-enddate
        net_amt      = ls_contract-rent_amt
        tax_amt      = 0
        total_amt    = ls_contract-rent_amt
        currency     = 'USD'
        status       = 'DRAFT'
        created_by   = sy-uname
        created_on   = cl_abap_context_info=>get_system_date( )
      ).

      INSERT zlmm_inv_hdr FROM @ls_hdr.
      IF sy-subrc <> 0.
        " handle error - add message if needed
        CONTINUE.
      ENDIF.

      " insert invoice item
      DATA(ls_item) = VALUE zlmm_inv_item(
        client     = sy-mandt
        invid      = lv_invid
        itemno     = 1
        description = |Rent for contract { lv_contractid }|
        quantity   = 1
        unit       = 'EA'
        unit_price = ls_contract-rent_amt
        line_total = ls_contract-rent_amt
        tax_percent = 0
      ).
      INSERT zlmm_inv_item FROM @ls_item.

      " Optionally, you can add return/modify the contract or set status to INVOICED
      UPDATE zlmm_contract SET status = 'INVOICED' WHERE contractid = @lv_contractid.

    ENDLOOP.

  ENDMETHOD.

  METHOD DefaultValues.
 " set default status and created_by/created_on on create
    LOOP AT keys INTO DATA(ls_key).
      DATA(lv_contractid) = ls_key-contractid.
      " set defaults using MODIFY ENTITY or do it client-side
      " nothing more required here if using direct DB insertion in handler
    ENDLOOP.
  ENDMETHOD.

  METHOD CheckDates.

   " Validate start <= end
    LOOP AT keys INTO DATA(ls_key).
      SELECT SINGLE  startdate, enddate FROM zlmm_contract  WHERE contractid = @ls_key-contractid INTO (@DATA(ld_start), @DATA(ld_end)).
      IF ld_start IS NOT INITIAL AND ld_end IS NOT INITIAL AND ld_start > ld_end.
        " raise error message - fill message to add to messages buffer
        " In behavior handler you'd use ABAP managed messages structure
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
