import 'package:kai_wisata/data/models/station.dart';
import 'package:kai_wisata/data/models/ticket_class.dart';

import 'package:intl/intl.dart';

class SearchTicketArguments {
  final Station? from;
  final Station? to;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool isReturn;
  final int seat;
  final int adult;
  final int child;
  final int baby;
  final TicketClass ticketClass;

  SearchTicketArguments(this.from, this.to, this.fromDate, this.toDate, this.isReturn, this.seat, this.adult, this.child, this.baby, this.ticketClass);

  String getShortWeekDay(DateTime date){
    return ["", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"][date.weekday];
  }

  String get shortFromDate => getShortWeekDay(fromDate!) + ", " + DateFormat("dd MMM").format(fromDate!);

  static SearchTicketArguments empty() {
    return SearchTicketArguments(
        Station("Pilih", "Pilih"),
        Station("Pilih", "Pilih"),
        DateTime.now(), DateTime.now(),
        false, 1, 1, 0, 0, TicketClass.economy);
  }

  factory SearchTicketArguments.fromJson(Map<String, dynamic> json){
    return SearchTicketArguments(
        Station(json["org_code"], json["org_name"]),
        Station(json["dest_code"], json["dest_name"]),
        DateTime.parse(json["departure_date"]),
        DateTime.parse(json["arrival_date"]),
        json["is_return"],
        json["seat"],
        json["adult"],
        json["child"],
        json["baby"],
        TicketClass.economy.fromString(json["class"]));
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
      "seat": seat,
      "adult": adult,
      "child": child,
      "baby": baby,
      "class": ticketClass.classToString()
    };
  }

  static List<SearchTicketArguments> listFromJson(List<dynamic> json) =>
      json.map((e) => SearchTicketArguments.fromJson(e)).toList();

  static List<Map<String, dynamic>> toJsonList(List<SearchTicketArguments> bookings) =>
      bookings.map((e) => e.toJson()).toList();

}