@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo Booking interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZSBM_I_DMO_BKNG_R
  as select from zsbm_dmo_bkng_m as _booking
  /* Composition with Booking Supplement  */
  composition [1..*] of ZSBM_I_DMO_BKSPL_R    as _bookingsup
  /* Association to Parent  */
  association        to parent ZSBM_I_DMO_TRVL_R     as _travel on  $projection.TravelId = _travel.TravelId
  /* Carrier Id association */
  association [0..1] to /DMO/I_Carrier        as _carrier       on  $projection.CarrierId = _carrier.AirlineID
  /* Customer association */
  association [0..1] to /DMO/I_Customer       as _customer      on  $projection.CustomerId = _customer.CustomerID
  /* Connection association */
  association [1..1] to /DMO/I_Connection     as _connection    on  $projection.ConnectionId = _connection.ConnectionID
                                                                and $projection.CarrierId    = _connection.AirlineID
  /* Booking status value association */
  association [1]    to /DMO/I_Booking_Status_VH as _status     on  $projection.BookingStatus = _status.BookingStatus


{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      last_changed_at as LastChangedAt,

      /* Composition  */
      _bookingsup,

      /* Associdation To Parent */
      _travel,

      /* Associdation */
      _carrier,
      _customer,
      _connection,
      _status

}
