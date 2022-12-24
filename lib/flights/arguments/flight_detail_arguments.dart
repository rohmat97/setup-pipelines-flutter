import 'package:kai_wisata/data/models/airport.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/flights/models/flight_detail_model.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';

class FlightDetailArguments {
  final String? tripType;
  final String? from;
  final String? to;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool? isReturn;
  final int? adult;
  final int? child;
  final int? infant;
  final FlightDetailModel? detail;
  final String? idSchDepart;
  final String? idSchReturn;

  FlightDetailArguments(this.from, this.to, this.fromDate, this.toDate, this.isReturn, this.adult, this.child, this.infant, this.tripType, this.detail, this.idSchDepart, this.idSchReturn);

  String getShortWeekDay(DateTime date){
    return ["", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"][date.weekday];
  }

  String get shortFromDate => getShortWeekDay(fromDate!) + ", " + DateFormat("dd MMM").format(fromDate!);

  static FlightDetailArguments empty() {
    return FlightDetailArguments(
      '',
      '',
      DateTime.now(), DateTime.now(),
      false,
      1,
      0,
      0,
      'OneWay',
      null,
      '',
      ''
    );
  }

  factory FlightDetailArguments.fromJson(Map<String, dynamic> json){
    return FlightDetailArguments(
      '',
      '',
      DateTime.parse(json["departure_date"]),
      DateTime.parse(json["return_date"]),
      json["is_return"],
      json["adult"],
      json["child"],
      json["infant"],
      json["trip_type"],
      json["detail"],
      json["id_depart"],
      json["id_return"],
    );
  }
}