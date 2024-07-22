@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
}
define view entity ZSBM_I_CONNECTION_TMC_01
  as select from /dmo/connection
{
      @UI.lineItem: [{ position: 10 , label: 'Airline'}]
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position: 20 }]
  key connection_id   as ConnectionId,
      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{ position: 30 }]
      airport_from_id as AirportFromId,
      @UI.selectionField: [{ position: 40 }]
      @UI.lineItem: [{ position: 40 }]
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50 , label: 'Departure Time' }]
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60 , label: 'Arrival Time' }]
      arrival_time    as ArrivalTime,
      @UI.lineItem: [{ position: 70 }]
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      @UI.lineItem: [{ position: 80 }]
      distance_unit   as DistanceUnit
}
