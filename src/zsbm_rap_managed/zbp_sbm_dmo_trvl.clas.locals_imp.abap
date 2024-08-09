CLASS lhc_ZSBM_I_DMO_TRVL_R DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zsbm_i_dmo_trvl_r RESULT result.
    METHODS earlynumbering_cba_booking FOR NUMBERING
      IMPORTING entities FOR CREATE zsbm_i_dmo_trvl_r\_booking.

    METHODS earlynumbering_create
      FOR NUMBERING
      IMPORTING entities FOR CREATE zsbm_i_dmo_trvl_r.

ENDCLASS.

CLASS lhc_ZSBM_I_DMO_TRVL_R IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    " Delete the records from the entities where the Travel Id has the value .
    DATA(lt_entities) = entities .
    DELETE lt_entities WHERE TravelId IS NOT INITIAL .

    " Get the next number
    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       =  '01'
            object            = '/DMO/TRV_M' " we are using the existing number range
            quantity          = CONV #( lines( lt_entities ) ) " how many numbers we want
          IMPORTING
            number            = DATA(lv_number)            " latest number
            returncode        = DATA(lv_returncode)        " Error code
            returned_quantity = DATA(lv_returned_quantity) " How many qty got returned
        ).
      CATCH cx_nr_object_not_found INTO DATA(lo_nr_object_not_found) .
        " Loop at the importing entities entries
        LOOP AT lt_entities INTO DATA(ls_entities).

          " Failed key identified by %cid
          APPEND VALUE #(  %cid = ls_entities-%cid
                           %key = ls_entities-%key
                            )
                     TO  failed-zsbm_i_dmo_trvl_r .

          " Failure message
          APPEND VALUE #(  %cid = ls_entities-%cid
                           %key = ls_entities-%key
                           %msg = lo_nr_object_not_found
                        )
                 TO  reported-zsbm_i_dmo_trvl_r .

        ENDLOOP.
        EXIT.

      CATCH cx_number_ranges INTO DATA(lo_number_ranges).
        " Loop at the importing entities entries
        LOOP AT lt_entities INTO ls_entities.

          " Failed key identified by %cid
          APPEND VALUE #(  %cid = ls_entities-%cid
                           %key = ls_entities-%key
                            )
                     TO  failed-zsbm_i_dmo_trvl_r .

          " Failure message
          APPEND VALUE #(  %cid = ls_entities-%cid
                           %key = ls_entities-%key
                           %msg = lo_number_ranges
                        )
                 TO  reported-zsbm_i_dmo_trvl_r .

        ENDLOOP.
        EXIT .
    ENDTRY.

    " check whether the requested qty and the returned qty is same or not
    ASSERT lines( lt_entities ) = lv_returned_quantity .

    " Data declaration for the mapped derived type
    DATA : lt_dmo_trvl_r TYPE TABLE FOR MAPPED EARLY zsbm_i_dmo_trvl_r,
           ls_dmo_trvl_r LIKE LINE OF lt_dmo_trvl_r.

    " Go back to the initial number
    lv_number = lv_number - lv_returned_quantity .

    " Loop at the importing entities entries
    LOOP AT lt_entities INTO ls_entities.

      lv_number += 1 . " Increase the number by 1 for each loop

      " target is to fill the MAPPED derived type with the travelId number
      APPEND VALUE #(  %cid = ls_entities-%cid
                       TravelId = lv_number )
                   TO mapped-zsbm_i_dmo_trvl_r .

    ENDLOOP.


  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.
  ENDMETHOD.

ENDCLASS.
