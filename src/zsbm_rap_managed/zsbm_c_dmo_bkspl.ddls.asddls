@EndUserText.label: 'Booking Supplement Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZSBM_C_DMO_BKSPL
  as projection on ZSBM_I_DMO_BKSPL_R
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      SupplementId,
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _booking : redirected to parent ZSBM_C_DMO_BKNG,
      _supplement,
      _supplementText,
      _travel : redirected to ZSBM_C_DMO_TRVL
}
