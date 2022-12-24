import 'package:kai_wisata/data/models/airport.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/flights/models/flight_booking_model.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';

class FlightBookingArguments {
  final String? idscdep;
  final String? idscret;
  final FlightBookingModel? booking;

  FlightBookingArguments(this.idscdep, this.idscret, this.booking);

  static FlightBookingArguments empty() {
    return FlightBookingArguments(
      '',
      '',
      null,
    );
  }

  factory FlightBookingArguments.fromJson(Map<String, dynamic> json){
    return FlightBookingArguments(
      json["id_schedule_departure"],
      json["id_schedule_return"],
      json["booking"],
    );
  }
}