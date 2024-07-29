@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSBM_I_DMO_BKSPL_R
  as select from zsbm_dmo_bkspl_m as _bookingsupplement
  /* association to Parent */
  association        to parent ZSBM_I_DMO_BKNG_R as _booking        on  $projection.TravelId  = _booking.TravelId
                                                                    and $projection.BookingId = _booking.BookingId

  /* supplement association */
  association [1..1] to /DMO/I_Supplement        as _supplement     on  $projection.SupplementId = _supplement.SupplementID
  /* supplement text association */
  association [1..*] to /DMO/I_SupplementText    as _supplementText on  $projection.SupplementId = _supplementText.SupplementID
  /* Travel informatiomn association */
  association [1..1] to ZSBM_I_DMO_TRVL_R        as _travel         on  $projection.TravelId = _travel.TravelId
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      last_changed_at       as LastChangedAt,

      /* Association to parent */
      _booking,

      /* Associations */
      _supplement,
      _supplementText,
      _travel
}
