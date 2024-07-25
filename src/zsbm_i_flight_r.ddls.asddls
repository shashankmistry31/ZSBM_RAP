@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight CDS Views'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZSBM_I_FLIGHT_R
  as select from /dmo/flight
  //  Carrier Id
  association [1] to ZSBM_I_CARRIER_R as _carrier on $projection.CarrierId = _carrier.CarrierId
{

      @UI.lineItem: [{ position: 10,  label: 'Carrier ID'  }]
      @ObjectModel.text.association: '_carrier'
  key carrier_id     as CarrierId,
      @UI.lineItem: [{ position: 20 }]
  key connection_id  as ConnectionId,
      @UI.lineItem: [{ position: 30  }]
  key flight_date    as FlightDate,
      @UI.lineItem: [{ position: 40  }]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,
      currency_code  as CurrencyCode,
      @UI.lineItem: [{ position: 50  }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      plane_type_id  as PlaneTypeId,
      @UI.lineItem: [{ position: 70  }]
      seats_max      as SeatsMax,
      @UI.lineItem: [{ position: 60  }]
      seats_occupied as SeatsOccupied,

      //    Association
      _carrier
}
