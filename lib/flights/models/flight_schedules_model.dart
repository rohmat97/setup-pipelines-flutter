import 'package:intl/intl.dart';

class FlightSchedulesModel {
  String? idReference;
  String? airline;
  String? airlineCode;
  String? flightNumber;
  String? flightType;
  String? flightClass;
  String? tripType;
  String? origin;
  String? destination;
  DateTime? departureDate;
  DateTime? arriveDate;
  DateTime? returnDate;
  String? category;
  double? priceDetail;
  String? travelTime;

  FlightSchedulesModel({
    this.idReference,
    this.airline,
    this.airlineCode,
    this.flightNumber,
    this.flightType,
    this.flightClass,
    this.tripType,
    this.origin,
    this.destination,
    this.departureDate,
    this.arriveDate,
    this.returnDate,
    this.category,
    this.priceDetail,
    this.travelTime,
  });

  FlightSchedulesModel.fromJson(Map<String, dynamic> json) {
    idReference = json['id_reference'];
    airline = json['airline'];
    airlineCode = json['airline_code'];
    flightNumber = json['flight_number'];
    flightType = json['flight_type'];
    flightClass = json['flight_class'];
    tripType = json['trip_type'];
    origin = json['origin'];
    destination = json['destination'];
    departureDate = DateTime.parse(json['departure_date']);
    arriveDate = DateTime.parse(json['arrive_date']);
    returnDate = json['return_date'] != "" ? DateTime.parse(json['return_date']) : null;
    category = json['category'];
    priceDetail = double.parse(json['price_per_person'].toString());
    travelTime = json['travel_time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_reference': idReference,
      'airline': airline,
      'airline_code': airlineCode,
      'flight_number': flightNumber,
      'flight_type': flightType,
      'flight_class': flightClass,
      'trip_type': tripType,
      'origin': origin,
      'destination': destination,
      'departure_date': departureDate?.toString(),
      'arrive_date': arriveDate?.toString(),
      'return_date': returnDate?.toString(),
      'category': category,
      'price_per_person': priceDetail,
      'travel_time': travelTime,
    };
  }
}
