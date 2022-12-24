import 'package:kai_wisata/data/models/airport.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';

class FlightResultArguments {
  final String? tripType;
  final String? from;
  final String? to;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool isReturn;
  final int? adult;
  final int? child;
  final int? infant;
  final FlightResultModel? result;

  FlightResultArguments(this.from, this.to, this.fromDate, this.toDate, this.isReturn, this.adult, this.child, this.infant, this.tripType, this.result);

  String getShortWeekDay(DateTime date){
    return ["", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"][date.weekday];
  }

  String get shortFromDate => getShortWeekDay(fromDate!) + ", " + DateFormat("dd MMM").format(fromDate!);

  static FlightResultArguments empty() {
    return FlightResultArguments(
      '',
      '',
      DateTime.now(), DateTime.now(),
      false,
      1,
      0,
      0,
      'OneWay',
      null,
    );
  }

  factory FlightResultArguments.fromJson(Map<String, dynamic> json){
    return FlightResultArguments(
      '',
      '',
      DateTime.parse(json["departure_date"]),
      DateTime.parse(json["return_date"]),
      json["is_return"],
      json["adult"],
      json["child"],
      json["infant"],
      json["trip_type"],
      json["result"],
    );
  }
}