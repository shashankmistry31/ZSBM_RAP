@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Read only DMO travel CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSBM_I_DMO_TRVL_R
  as select from zsbm_dmo_trvl_m
  association [0..1] to /DMO/I_Agency   as _agency   on $projection.AgencyId = _agency.AgencyID
  association [0..1] to /DMO/I_Customer as _customer on $projection.CustomerId = _customer.CustomerID
  association [0..1] to I_Currency      as _currency on $projection.CurrencyCode = _currency.Currency
  association [0..1] to /DMO/I_Overall_Status_VH      as _status on $projection.OverallStatus = _status.OverallStatus

{
  key travel_id       as TravelId,
      agency_id       as AgencyId,
      customer_id     as CustomerId,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee     as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price     as TotalPrice,
      currency_code   as CurrencyCode,
      description     as Description,
      overall_status  as OverallStatus,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,

      /* Association */
      _agency,
      _customer,
      _currency,
      _status

}
