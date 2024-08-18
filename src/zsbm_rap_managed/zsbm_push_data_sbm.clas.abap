CLASS zsbm_push_data_sbm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSBM_PUSH_DATA_SBM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DELETE FROM zsbm_dmo_trvl_m.
    DELETE FROM zsbm_dmo_bkng_m.
    DELETE FROM zsbm_dmo_bkspl_m.
    COMMIT WORK.
    " insert travel demo data
    INSERT zsbm_dmo_trvl_m FROM (
        SELECT *
          FROM /dmo/travel_m
      ).
    COMMIT WORK.

    " insert booking demo data
    INSERT zsbm_dmo_bkng_m FROM (
        SELECT *
          FROM   /dmo/booking_m
*            JOIN ztravel_tech_m AS z
*            ON   booking~travel_id = z~travel_id

      ).
    COMMIT WORK.
    INSERT zsbm_dmo_bkspl_m FROM (
        SELECT *
          FROM   /dmo/booksuppl_m
*            JOIN ztravel_tech_m AS z
*            ON   booking~travel_id = z~travel_id

      ).
    COMMIT WORK.

    out->write( ' Completed ' ).

  ENDMETHOD.
ENDCLASS.
