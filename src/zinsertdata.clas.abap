CLASS zinsertdata DEFINITION
  PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zinsertdata IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.




    DATA(ls_contract) = VALUE zlmm_contract(
      contractid = 'C004'
      assetid    = 'A004'
      tenantid   = 'T004'
      startdate  = '20250110'
      enddate    = '20251210'
      rent_amt   = '1900'
      status     = 'ACTIVE'




    ).

    INSERT zlmm_contract FROM @ls_contract.
    COMMIT WORK.


  ENDMETHOD.

ENDCLASS.
