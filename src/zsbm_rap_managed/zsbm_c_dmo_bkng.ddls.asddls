@EndUserText.label: 'Managed Consumption Projection view for Booking'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZSBM_C_DMO_BKNG
  as projection on ZSBM_I_DMO_BKNG_R
{
  key TravelId,
  key BookingId,
      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      BookingStatus,
      LastChangedAt,
      /* Associations */
      _bookingsup : redirected to composition child ZSBM_C_DMO_BKSPL,
      _carrier,
      _connection,
      _customer,
      _status,
      _travel : redirected to parent ZSBM_C_DMO_TRVL
}
