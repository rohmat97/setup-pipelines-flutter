import 'dart:convert';

import 'package:kai_wisata/flights/models/details/flight_price_detail_model.dart';

class FlightJourneyReturnModel {
  String? idReference;
  String? flightNumber;
  String? flightType;
  String? flightClass;
  String? origin;
  String? destination;
  DateTime? departureDate;
  DateTime? arriveDate;
  String? currency;
  List<FlightPriceDetailModel>? prices;
  
  FlightJourneyReturnModel({
    this.idReference,
    this.flightNumber,
    this.flightType,
    this.flightClass,
    this.currency,
    this.origin,
    this.destination,
    this.departureDate,
    this.arriveDate,
    this.prices,
  });

  FlightJourneyReturnModel.fromJson(Map<String, dynamic> json) {
    idReference = json['id'];
    flightNumber = json['flight_number'];
    flightType = json['flight_type'];
    flightClass = json['flight_class'];
    origin = json['origin'];
    destination = json['destination'];
    departureDate = DateTime.parse(json['departure_time']);
    arriveDate = DateTime.parse(json['arrive_time']);
    currency = json['currency'];
    prices = json["price_detail"] != null ? json["price_detail"].map<FlightPriceDetailModel>((price) => FlightPriceDetailModel.fromJson(price)).toList() : [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_reference': idReference,
      'flight_number': flightNumber,
      'flight_type': flightType,
      'flight_class': flightClass,
      'origin': origin,
      'destination': destination,
      'departure_date': departureDate?.toString(),
      'arrive_date': arriveDate?.toString(),
      'currency': currency,
      'price_detail': prices?.map((price) => price.toJson()).toList(),
    };
  }
}

class UninitializedFlightJourneyReturnModel extends FlightJourneyReturnModel {}