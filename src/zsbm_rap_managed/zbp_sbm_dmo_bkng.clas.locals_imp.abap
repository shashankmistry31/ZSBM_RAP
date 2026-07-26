CLASS lhc_zsbm_i_dmo_bkng_r DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS earlynumbering_cba_Bookingsup FOR NUMBERING
      IMPORTING entities FOR CREATE ZSBM_I_DMO_BKNG_R\_Bookingsup.

ENDCLASS.

CLASS lhc_zsbm_i_dmo_bkng_r IMPLEMENTATION.

  METHOD earlynumbering_cba_Bookingsup.

*---------------- begin of changes by Shashank ----------------
    " MAX_OF_SIBLINGS numbering: new BookingSupplementId = highest sibling + 1 .
    DATA lv_max_bkspl_id TYPE /dmo/booking_supplement_id .

    " Existing supplements of the requested bookings (keys only)
    READ ENTITIES OF zsbm_i_dmo_trvl_r IN LOCAL MODE
      ENTITY zsbm_i_dmo_bkng_r BY \_bookingsup
        FROM CORRESPONDING #( entities )
        LINK DATA(lt_bookingsups) .

    " One group per booking instance . %tky (not the bare BookingId) keeps
    " draft and active instances apart and survives a draft-enabled BO .
    " ls_entity is the group representative, the group members are read
    " with LOOP AT GROUP below .
    LOOP AT entities INTO DATA(ls_entity) USING KEY entity
         GROUP BY ls_entity-%tky .

      " (1) Highest BookingSupplementId already persisted/buffered - once per group
      lv_max_bkspl_id = REDUCE #( INIT max = CONV /dmo/booking_supplement_id( '0' )
                                  FOR  bookingsup IN lt_bookingsups USING KEY entity
                                       WHERE ( source-%tky = ls_entity-%tky )
                                  NEXT max = COND #( WHEN bookingsup-target-BookingSupplementId > max
                                                     THEN bookingsup-target-BookingSupplementId
                                                     ELSE max ) ) .

      " (2) Rows that already carry an id count towards the max as well
      LOOP AT GROUP ls_entity INTO DATA(ls_member) .
        LOOP AT ls_member-%target INTO DATA(ls_bookingsup) .
          IF ls_bookingsup-BookingSupplementId > lv_max_bkspl_id .
            lv_max_bkspl_id = ls_bookingsup-BookingSupplementId .
          ENDIF .
        ENDLOOP .
      ENDLOOP .

      " (3) Hand out the numbers - one running counter for the whole group
      LOOP AT GROUP ls_entity INTO ls_member .
        LOOP AT ls_member-%target INTO ls_bookingsup .

          APPEND CORRESPONDING #( ls_bookingsup ) TO mapped-zsbm_i_dmo_bkspl_r
                 ASSIGNING FIELD-SYMBOL(<ls_mapped_bookingsup>) .

          " Only unnumbered rows get a new id, supplied ones are mapped through
          IF ls_bookingsup-BookingSupplementId IS INITIAL .
            lv_max_bkspl_id += 1 .
            <ls_mapped_bookingsup>-BookingSupplementId = lv_max_bkspl_id .
          ENDIF .

        ENDLOOP .
      ENDLOOP .

    ENDLOOP .
*---------------- end of changes by Shashank ------------------


  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
