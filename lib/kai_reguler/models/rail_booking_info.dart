
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:intl/intl.dart';

class RailTicket {
  String name = "";
  String seat = "";

  RailTicket(this.name, this.seat);

  factory RailTicket.fromJson(Map<String, dynamic> json){
    return RailTicket(json["name"], json["seat"]);
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "seat": seat,
  };

  static List<RailTicket> parseListJson(List<dynamic> listJson) => listJson.map((e) => RailTicket.fromJson(e)).toList();
}

class RailRouteInfo {
  String transporterType = "";
  String transporterNo = "";
  String transporterName = "";
  String transporterBookCode = "";
  String org = "";
  String des = "";
  DateTime depDate = DateTime.now();
  DateTime arvDate = DateTime.now();
  String bookStatus = "";
  String ccy = "";
  int basicFare = 0;
  int discount = 0;
  int additionalFee = 0;
  int totalPrice = 0;
  List<RailTicket> tickets = [];

  RailRouteInfo(this.transporterType, this.transporterNo, this.transporterName,
      this.transporterBookCode, this.org, this.des, this.depDate, this.arvDate,
      this.bookStatus,
      this.ccy, this.basicFare, this.discount, this.additionalFee,
      this.totalPrice, this.tickets);

  String get totalFormatted => NumberFormat.decimalPattern('id').format(totalPrice);
  String get additionalFeeFormatted => NumberFormat.decimalPattern('id').format(additionalFee);
  String get basicFareFormatted => NumberFormat.decimalPattern('id').format(basicFare);

  String get duration  {
    var diff = arvDate.difference(depDate);
    var hours = (diff.inMinutes / 60).round();
    var minutes = diff.inMinutes - (hours*60);

    var str = "";
    if(hours > 0) {
      str = str + '$hours j';
    }
    if(minutes > 0) {
      str = str + " $minutes m";
    }
    return str;
  }

  static RailRouteInfo empty() {
    return RailRouteInfo(
        "",
        "",
        "",
        "",
        "",
        "",
        DateTime.now(),
        DateTime.now(),
        "",
        "",
        0,
        0,
        0,
        0,
        []);
  }

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
        0
    );
  }

  factory RailRouteInfo.fromJson(Map<String, dynamic> json) {
    return RailRouteInfo(
        json["transporter_type"],
        json["transporter_no"],
        json["transporter_name"],
        json["transporter_book_code"],
        json["org"],
        json["des"],
        toDateTime(json["dep_date"]),
        toDateTime(json["arv_date"]),
        json["book_status"],
        json["ccy"],
        int.parse(json["basic_fare"]),
        int.parse(json["discount"]),
        int.parse(json["additional_fee"]),
        int.parse(json["total_price"]),
        RailTicket.parseListJson(json["ticket"]));
  }

  Map<String, dynamic> toJson() => {
    "transporter_type": transporterType,
    "transporter_no": transporterNo,
    "transporter_name": transporterName,
    "transporter_book_code": transporterBookCode,
    "org": org,
    "des": des,
    "dep_date": depDate,
    "arv_date": arvDate,
    "book_status": bookStatus,
    "ccy": ccy,
    "basic_fare": basicFareFormatted,
    "discount": discount,
    "additional_fee": additionalFeeFormatted,
    "total_price": totalFormatted,
    "ticket" : tickets.map((tc) => tc.toJson()).toList(),
  };

  static List<RailRouteInfo> parseListJson(List<dynamic> listJson) => listJson.map((e) => RailRouteInfo.fromJson(e)).toList();
}

class RailPaxInfo {
  String paxName = "";
  String birthDate = "";
  String mobile = "";
  String idNumber = "";
  String paxType = "";
  String vaccine = "";

  RailPaxInfo(this.paxName, this.birthDate, this.mobile, this.idNumber, this.paxType, this.vaccine);

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
        0
    );
  }

  factory RailPaxInfo.fromJson(Map<String, dynamic> json){
    return RailPaxInfo(
        json["pax_name"],
        json["birthdate"],
        json["mobile"],
        json["id_number"],
        json["pax_type"],
        json["vaccine"]);
  }

  Map<String, dynamic> toJson() => {
    "pax_name": paxName,
    "birthdate": birthDate,
    "mobile": mobile,
    "id_number": idNumber,
    "pax_type": paxType,
    "vaccine": vaccine,
  };

  static List<RailPaxInfo> parseListJson(List<dynamic> listJson) => listJson.map((e) => RailPaxInfo.fromJson(e)).toList();
}

class RailBookingInfo {
  String gdsBookCode = "";
  String gdsBookStatus = "";
  DateTime timeLimit  = DateTime.now();
  DataCaller dataCaller = DataCaller.empty();
  List<RailPaxInfo> paxInfos = [];
  List<RailRouteInfo> routeInfo = [];

  RailBookingInfo(this.gdsBookCode, this.gdsBookStatus, this.timeLimit, this.dataCaller, this.paxInfos, this.routeInfo);

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
        0
    );
  }

  factory RailBookingInfo.fromJson(Map<String, dynamic> json){
    var gdsBookCode = json["gds_book_code"];
    var gdsBookStatus = json["gds_book_status"];
    var timeLimit = toDateTime(json["time_limit"]);

    var dataCaller = DataCaller("", json["name"], json["number"]);
    var paxInfos = RailPaxInfo.parseListJson(json["pax_info"]);
    var routeInfo = RailRouteInfo.parseListJson(json["route_info"]);

    return RailBookingInfo(
      gdsBookCode,
      gdsBookStatus,
      timeLimit,
      dataCaller,
      paxInfos,
      routeInfo
    );
  }

  Map<String, dynamic> toJson() => {
    "gds_book_code": gdsBookCode,
    "name": dataCaller.name,
    "number": dataCaller.phone,
    "title": dataCaller.title,
    "gds_book_status": gdsBookStatus,
    "time_limit": timeLimit,
    "pax_info": paxInfos.map((pi) => pi.toJson()).toList(),
    "route_info": routeInfo.map((ri) => ri.toJson()).toList(),
  };

  static RailBookingInfo empty() {
    return RailBookingInfo("", "", DateTime.now(), DataCaller.empty(), [], List<RailRouteInfo>.empty());
  }
}

