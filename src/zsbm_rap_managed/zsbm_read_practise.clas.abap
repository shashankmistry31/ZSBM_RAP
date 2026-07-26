CLASS zsbm_read_practise DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zsbm_read_practise IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    READ ENTITY zsbm_i_dmo_trvl_r
*    BY \_booking
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00004199' )
*                   ( %key-TravelId = '00004198' ) )
*    RESULT DATA(lt_result)
*    FAILED DATA(lt_failed).
*
*    IF lt_failed IS NOT INITIAL.
*
*      out->write( |Hello from VSP MCP - hands-free write works!| ).
*
*    ELSE.
*
*      out->write( lt_result ).
*
*    ENDIF.

*    READ ENTITIES OF zsbm_i_dmo_trvl_r
*
*    ENTITY zsbm_i_dmo_trvl_r
*    ALL FIELDS WITH VALUE #( ( %key-TravelId = '00004199' )
*                             ( %key-TravelId = '00004198' ) )
*    RESULT DATA(lt_result_trvl)
*
*    ENTITY zsbm_i_dmo_bkng_r
*    ALL FIELDS WITH VALUE #( ( %key-TravelId = '00004199' %key-BookingId = '001' )
*                             ( %key-TravelId = '00004198' %key-BookingId = '004' ) )
*    RESULT DATA(lt_result_bkng)
*
*    FAILED DATA(lt_failed_mult).
*
*    IF lt_failed_mult IS NOT INITIAL.
*
*      out->write( |Hello from VSP MCP - hands-free write works!| ).
*
*    ELSE.
*
*      out->write( lt_result_trvl ).
*      out->write( lt_result_bkng ).
*
*    ENDIF.

    DATA : lt_operation_tab TYPE abp_behv_retrievals_tab .
    DATA : lt_input_val_tab TYPE TABLE FOR READ IMPORT   zsbm_i_dmo_trvl_r .
    DATA : lt_result_val_tab TYPE TABLE FOR READ RESULT     zsbm_i_dmo_trvl_r .
    DATA : lt_booking_input_val_tab TYPE TABLE FOR READ IMPORT   zsbm_i_dmo_trvl_r\_booking .
    DATA : lt_booking_result_val_tab TYPE TABLE FOR READ RESULT  zsbm_i_dmo_trvl_r\_booking .

    lt_input_val_tab = VALUE #( ( %key-TravelId = '00004199'
                                  %control = VALUE #( AgencyId = if_abap_behv=>mk-on
                                                    BeginDate = if_abap_behv=>mk-on  )
                                                )
                                ( %key-TravelId = '00004198' )
                                 ).

*    Association
    lt_booking_input_val_tab = VALUE #( ( %key-TravelId = '00004199'
                                          %control = VALUE #( BookingDate = if_abap_behv=>mk-on
                                                              BookingStatus = if_abap_behv=>mk-on  )
                                                )

                                        ( %key-TravelId = '00004198'
                                          %control = VALUE #( BookingDate = if_abap_behv=>mk-on
                                                              BookingStatus = if_abap_behv=>mk-on
                                                              BookingId     = if_abap_behv=>mk-on  )
                                                ) ).


    lt_operation_tab = VALUE #( ( op = if_abap_behv=>op-r-read
                                entity_name = 'ZSBM_I_DMO_TRVL_R'
                                instances   = REF #( lt_input_val_tab )
                                results     = REF #( lt_result_val_tab ) )
*   Association Operation
                               ( op = if_abap_behv=>op-r-read_ba
                                entity_name = 'ZSBM_I_DMO_TRVL_R'
                                sub_name    = '_BOOKING'
                                instances   = REF #( lt_booking_input_val_tab )
                                results     = REF #( lt_booking_result_val_tab ) )
                            ) .

    READ ENTITIES OPERATIONS lt_operation_tab
    FAILED DATA(lt_failed_mult).

    IF lt_failed_mult IS NOT INITIAL.
*
      out->write( |Hello from VSP MCP - hands-free write works!| ).

    ELSE.

      out->write( lt_result_val_tab ).
      out->write( lt_booking_result_val_tab ).

    ENDIF.

  ENDMETHOD.


ENDCLASS.
