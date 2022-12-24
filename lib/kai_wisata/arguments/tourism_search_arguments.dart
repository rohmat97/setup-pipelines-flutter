import 'package:kai_wisata/data/models/station.dart';

import 'package:intl/intl.dart';

class TourismSearchArguments {
  final Station? from;
  final Station? to;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool isReturn;
  final String skema;

  TourismSearchArguments(this.from, this.to, this.fromDate, this.toDate, this.isReturn, this.skema);

  String getShortWeekDay(DateTime date){
    return ["", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"][date.weekday];
  }

  String get shortFromDate => getShortWeekDay(fromDate!) + ", " + DateFormat("dd MMM").format(fromDate!);

  static TourismSearchArguments empty() {
    return TourismSearchArguments(
        Station("Pilih", "Pilih"),
        Station("Pilih", "Pilih"),
        DateTime.now(), DateTime.now(),
        false, "Fit/Perorangan");
  }

  factory TourismSearchArguments.fromJson(Map<String, dynamic> json){
    return TourismSearchArguments(
        Station(json["org_code"], json["org_name"]),
        Station(json["dest_code"], json["dest_name"]),
        DateTime.parse(json["departure_date"]),
        DateTime.parse(json["arrival_date"]),
        json["is_return"],
        "Fit/Perorangan",
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "org_code": from?.code,
      "org_name": from?.name,
      "dest_code": to?.code,
      "dest_name": to?.name,
      "departure_date": fromDate?.toString(),
      "arrival_date": toDate?.toString(),
      "is_return": isReturn,
      "skema" : skema,
    };
  }

  static List<TourismSearchArguments> listFromJson(List<dynamic> json) =>
      json.map((e) => TourismSearchArguments.fromJson(e)).toList();

  static List<Map<String, dynamic>> toJsonList(List<TourismSearchArguments> bookings) =>
      bookings.map((e) => e.toJson()).toList();

}