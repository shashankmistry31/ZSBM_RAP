@EndUserText.label: 'Consumption Projection View for Travel root entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZSBM_C_DMO_TRVL
  provider contract transactional_query
  as projection on ZSBM_I_DMO_TRVL_R
{
  key TravelId,
      @ObjectModel.text.element: [ 'agencyName' ]
      AgencyId,
      /* added for description */
      _agency.Name        as agencyName,
      @ObjectModel.text.element: [ 'customerName' ]
      CustomerId,
      /* added for description */
      _customer.FirstName as customerName,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      CurrencyCode,
      Description,
      @ObjectModel.text.element: [ 'statusText' ]
      OverallStatus,
      /* added for description */
      _status._Text.Text  as statusText : localized,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _agency,
      _booking : redirected to composition child ZSBM_C_DMO_BKNG,
      _currency,
      _customer,
      _status
}
