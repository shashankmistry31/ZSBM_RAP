@EndUserText.label: 'Managed Consumption Projection view for Booking'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZSBM_C_DMO_BKNG
  as projection on ZSBM_I_DMO_BKNG_R
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element: [ 'FirstName' ]
      CustomerId,
      _customer.FirstName as FirstName,
      @ObjectModel.text.element: [ 'AirlineId' ]
      CarrierId,
      _carrier.Name       as AirlineId,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element: [ 'BookingStatusText' ]
      @UI.textArrangement: #TEXT_ONLY
      BookingStatus,
      _status._Text.Text             as BookingStatusText : localized,
      LastChangedAt,
      /* Associations */
      _bookingsup : redirected to composition child ZSBM_C_DMO_BKSPL,
      _carrier,
      _connection,
      _customer,
      _status,
      _travel     : redirected to parent ZSBM_C_DMO_TRVL
}
