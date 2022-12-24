import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:kai_wisata/data/cache/hive_repository.dart';

class TourismSchedule extends KaiObject {
  /*
      "org": "BD",
      "des": "GMR",
      "dep_datetime": "20/10/2022 - 06:10",
      "arv_datetime": "20/10/2022 - 08:50",
      "transporter_no": "43A",
      "transporter_name": "ARGO PARAHYANGAN",
      "vendor_id": 2
   */

  final String origin;
  final String destination;
  final String vendor;
  final DateTime departureTime;
  final DateTime returnTime;
  final DateTime arrivalTime;
  final String kelas;
  final int adultFare;
  final int adultDiscount;
  final int infantFare;
  final int infantDiscount;
  final String transporterNo;
  final String subClass;
  final int vendorId;
  final String transporterName;

  TourismSchedule(
      this.origin,
      this.destination,
      this.vendor,
      this.departureTime,
      this.returnTime,
      this.arrivalTime,
      this.kelas,
      this.adultFare,
      this.adultDiscount,
      this.infantFare,
      this.infantDiscount,
      this.transporterNo,
      this.subClass,
      this.vendorId,
      this.transporterName);

  String get duration {
    var diff = arrivalTime.difference(departureTime);
    var hours = (diff.inMinutes / 60).round();
    var minutes = diff.inMinutes - (hours * 60);

    var str = "";
    if (hours > 0) {
      str = str + '$hours j';
    }
    if (minutes > 0) {
      str = str + " $minutes m";
    }
    return str;
  }

  String get hourDepart => DateFormat("HH:mm").format(departureTime);
  String get hourArrive => DateFormat("HH:mm").format(arrivalTime);
  String get durationInfo => hourDepart + " - " + hourArrive;
  String get timeAndStationDesc =>
      "$hourDepart ($origin) - $hourArrive ($destination)";

  String getDayName(DateTime date) {
    return [
      "",
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jum'at",
      "Sabtu",
      "Minggu"
    ][date.weekday];
  }

  String get longDate =>
      "${getDayName(departureTime)}, ${DateFormat('dd MMM yyyy').format(departureTime)}";

  static String formatDateTime(DateTime date) =>
      DateFormat("dd/MM/yyyy - HH:mm").format(date);

  static DateTime toDateTime(String str) {
    var params = str.split("-");
    var hours = params[1].trim().split(":");

    var dateParams = params[0].split("/");
    return DateTime(
        int.parse(dateParams[2]),
        int.parse(dateParams[1]),
        int.parse(dateParams[0]),
        int.parse(hours[0]),
        int.parse(hours[1]),
        0,
        0,
        0);
  }

  factory TourismSchedule.fromJson(Map<String, dynamic> json) {
    return TourismSchedule(
        json["origin"],
        json["destination"],
        json["vendor"],
        toDateTime(json["depature_time"]),
        json["return_time"] != null
            ? toDateTime(json["return_time"])
            : DateTime.now(),
        toDateTime(json["arrival_time"]),
        json["class"],
        int.parse(json["adult_price"]),
        int.parse(json["adult_discounted_price"]),
        int.parse(json["infant_price"]),
        int.parse(json["infant_discounted_price"]),
        json["transporter_no"],
        json["sub_class"],
        json["vendor_id"],
        json["transporter_name"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "org": origin,
      "des": destination,
      "vendor": vendor,
      "depature_time": formatDateTime(departureTime),
      "arrival_time": formatDateTime(arrivalTime),
      "class": kelas,
      "adult_fare": adultFare.toString(),
      "adult_discount": adultDiscount.toString(),
      "infant_fare": infantFare.toString(),
      "infant_discount": infantDiscount.toString(),
      "transporter_no": transporterNo,
      "subclass": subClass,
      "vendor_id": vendorId,
      "transporter_name": transporterName
    };
  }

  static TourismSchedule deserialize(String str) =>
      TourismSchedule.fromJson(jsonDecode(str));

  static String serialize(TourismSchedule t) => jsonEncode(t.toJson());

  @override
  String getId() {
    return "$origin-$destination-${DateFormat("ddMMyyyy").format(departureTime)}";
  }
}
