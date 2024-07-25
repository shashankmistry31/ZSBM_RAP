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
@Search.searchable: true
define view entity ZSBM_I_CONNECTION_TMC_01
  as select from /dmo/connection as _connection
  // Flight association
  association [1..*] to ZSBM_I_FLIGHT_R  as _flight  on  $projection.CarrierId    = _flight.CarrierId
                                                     and $projection.ConnectionId = _flight.ConnectionId
  //  Carrier Id
  association [1]    to ZSBM_I_CARRIER_R as _carrier on  $projection.CarrierId = _carrier.CarrierId
{
      @UI.facet: [{
          id     :  'Connection',
          purpose: #STANDARD,
          label: 'Connection Details',
          type: #IDENTIFICATION_REFERENCE,
          position: 10
      },{
          id     :  'Flight',
          purpose: #STANDARD,
          label: 'Flights',
          type: #LINEITEM_REFERENCE,
          position: 20,
          targetElement: '_flight'
      }]


      @UI.identification: [{ position: 10  }]
      @UI.lineItem: [{ position: 10 , label: 'Airline'}]
      @ObjectModel.text.association: '_carrier'
      @Search.defaultSearchElement: true
  key carrier_id      as CarrierId,

      @UI.identification: [{ position: 20  }]
      @UI.lineItem: [{ position: 20 }]
  key connection_id   as ConnectionId,


      @UI.identification: [{ position: 30  }]
      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{ position: 30 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: 'ZSBM_I_AIRPORT_R',
              element: 'AirportId'
          }
      }]
      @EndUserText.label: 'Departure Airport'
      airport_from_id as AirportFromId,


      @UI.identification: [{ position: 40  }]
      @UI.selectionField: [{ position: 40  }]
      @UI.lineItem: [{ position: 40 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: 'ZSBM_I_AIRPORT_R',
              element: 'AirportId'
          }
      }]
      @EndUserText.label: 'Arrival Airport'
      airport_to_id   as AirportToId,

      @UI.identification: [{ position: 50  }]
      @UI.lineItem: [{ position: 50 , label: 'Departure Time' }]
      departure_time  as DepartureTime,


      @UI.identification: [{ position: 60  }]
      @UI.lineItem: [{ position: 60 , label: 'Arrival Time' }]
      arrival_time    as ArrivalTime,



      @UI.identification: [{ position: 70  }]
      @UI.lineItem: [{ position: 70 }]
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,

      @UI.lineItem: [{ position: 80 }]
      distance_unit   as DistanceUnit,

      //      Association
      @Search.defaultSearchElement: true
      _flight,

      @Search.defaultSearchElement: true
      _carrier

}
