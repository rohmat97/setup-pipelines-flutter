import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

import '../../data/cache/hive_repository.dart';

class DataCaller {
  String title;
  String name;
  String phone;

  DataCaller(this.title, this.name, this.phone);
  
  factory DataCaller.fromJson(Map<String, dynamic> json){
    return DataCaller(
      json["title"],
      json["name"],
      json["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'name': name,
    'phone' : phone
  };

  @override
  String toString(){
    return title == ""? name : "$title $name";
  }

  static DataCaller empty() {
    return DataCaller("", "", "");
  }
}

class Passenger {
  int id;
  String title;
  String name;
  String identity;
  String src;

  Passenger(this.id, this.title, this.name, this.identity, this.src);

  @override
  String toString(){
    return title == ""? name : "$title $name";
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'identity': identity
  };
  
  factory Passenger.fromJson(Map<String, dynamic> json){
    return Passenger(
        1,
        "Tuan",
        json['name'],
        json['identity'],
        "KTP/SIM"
    );
  }

  static List<Passenger> listFromJson(List<dynamic> json) {
    return json.map((e) => Passenger.fromJson(e)).toList();
  }

  static Passenger empty(int idx) {
    return Passenger(idx, "", "", "", "");
  }
}

class DepartCart {
  int depId;
  int userId;
  String origin;
  String destination;
  String departureDate;
  String transporterNo;
  String transporterClass;
  String transporterSubClass;
  int vendorId;
  String createdAt;
  String updatedAt;

  DepartCart(
    this.depId,
    this.userId,
    this.origin,
    this.destination,
    this.departureDate,
    this.transporterNo,
    this.transporterClass,
    this.transporterSubClass,
    this.vendorId,
    this.createdAt,
    this.updatedAt,
  );
  
  factory DepartCart.fromJson(Map<String, dynamic> json){
    return DepartCart(
      json["id"],
      json["user_id"],
      json["origin"],
      json["destination"],
      json["departure_date"],
      json["transporter_no"],
      json["transporter_class"],
      json["transporter_sub_class"],
      json["vendor_id"],
      json["created_at"],
      json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": depId,
    "user_id": userId,
    "origin": origin,
    "destination": destination,
    "departure_date": departureDate,
    "transporter_no": transporterClass,
    "transporter_class": transporterClass,
    "transporter_sub_class": transporterSubClass,
    "vendor_id": vendorId,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };

  static DateTime parseDate(String str) {
    var year = str.substring(0, 3);
    var month = str.substring(4, 5);
    var day = str.substring(6, 7);

    return DateTime(
      int.parse(year),
      int.parse(month),
      int.parse(day)
    );
  }
}

class ReturnCart {
  int retId;
  int userId;
  String origin;
  String destination;
  String returnDate;
  String transporterNo;
  String transporterClass;
  String transporterSubClass;
  int vendorId;
  String createdAt;
  String updatedAt;

  ReturnCart(
    this.retId,
    this.userId,
    this.origin,
    this.destination,
    this.returnDate,
    this.transporterNo,
    this.transporterClass,
    this.transporterSubClass,
    this.vendorId,
    this.createdAt,
    this.updatedAt,
  );
  
  factory ReturnCart.fromJson(Map<String, dynamic> json){
    return ReturnCart(
      json["id"],
      json["user_id"],
      json["origin"],
      json["destination"],
      json["return_date"],
      json["transporter_no"],
      json["transporter_class"],
      json["transporter_sub_class"],
      json["vendor_id"],
      // DateFormat("yyyy-MM-dd").parse(json["created_at"]),
      // DateFormat("yyyy-MM-dd").parse(json["updated_at"]),
      json["created_at"],
      json["updated_at"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": retId,
    "user_id": userId,
    "origin": origin,
    "destination": destination,
    "departure_date": returnDate,
    "transporter_no": transporterClass,
    "transporter_class": transporterClass,
    "transporter_sub_class": transporterSubClass,
    "vendor_id": vendorId,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };

  static DateTime parseDate(String str) {
    var year = str.substring(0, 3);
    var month = str.substring(4, 5);
    var day = str.substring(6, 7);

    return DateTime(
      int.parse(year),
      int.parse(month),
      int.parse(day)
    );
  }
}

class RailBooking extends KaiObject {
  DepartCart idDepCart;
  ReturnCart idretCart;
  double departPrice;
  double returnPrice;
  double estimatedTotalPrice;
  DataCaller dataCaller;
  List<Passenger> adults;
  List<Passenger> infants;

  RailBooking(this.idDepCart, this.idretCart, this.departPrice, this.returnPrice, this.estimatedTotalPrice, this.dataCaller, this.adults, this.infants);

  // get departHour => DateFormat("HH:mm").format(departureDate);
  // get arrivHour => DateFormat("HH:mm").format(arrivalDate);

  // String getShortWeekDay(DateTime date){
  //   return ["", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"][date.weekday];
  // }

  // String get shortFromDate => getShortWeekDay(departureDate) + ", " + DateFormat("dd MMM").format(departureDate);

  // static DateTime parseDate(String str) {
  //   var year = str.substring(0, 3);
  //   var month = str.substring(4, 5);
  //   var day = str.substring(6, 7);

  //   return DateTime(
  //       int.parse(year),
  // DateFormat("yyyy-MM-dd").parse(//       int.parse(month)),
  //       int.parse(day)
  //   );
  // }

  static List<RailBooking> listFromJson(List<Map<String, dynamic>> json) => json.map((e) => RailBooking.fromJson(e)).toList();

  static List<Map<String, dynamic>> toJsonList(List<RailBooking> bookings) =>
    bookings.map((e) => e.toJson()).toList();

  factory RailBooking.fromJson(Map<String, dynamic> json){
    return RailBooking(
      DepartCart.fromJson(json['depart_cart']),
      ReturnCart.fromJson(json['return_cart']),
      double.parse(json['depart_price'].toString()),
      double.parse(json['return_price'].toString()),
      double.parse(json['estimated_total_price'].toString()),
      DataCaller.fromJson(json['data_caller']),
      Passenger.listFromJson(json["passenger_adult"]),
      Passenger.listFromJson(json["passenger_infant"]),
    );
  }
  
  Map<String, dynamic> toJson() => {
    "cart_depart_id": idDepCart.depId.toString(),
    "cart_return_id": idretCart.retId.toString(),
    "data_contact" : dataCaller.toJson(),
    "data_passenger" : {
      "adult": adults.map((e) => e.toJson()).toList(),
      "infant": infants.map((e) => e.toJson()).toList(),
    },
  };

  static RailBooking deserialize(String str) => RailBooking.fromJson(jsonDecode(str));
  static String serialize(RailBooking t) => jsonEncode(t.toJson());
  
  @override
  String getId() {
    // TODO: implement getId
    throw UnimplementedError();
  }

  // @override
  // String getId() {
  //   return "$org-$des-${DateFormat("ddMMyyyy").format(departureDate)}";
  // }

  // static RailBooking fromSchedule(RailSchedule schedule) {
  //   return RailBooking(
  //     schedule.origin,
  //     schedule.destination,
  //     schedule.origin,
  //     schedule.destination,
  //     schedule.departureTime,
  //     schedule.arrivalTime,
  //     schedule.transporterNo,
  //     schedule.subClass,
  //     schedule.vendorId,
  //     DataCaller.empty(),
  //     [],
  //     []
  //   );
  // }

  static copyWithDataCaller(RailBooking old, DataCaller dataCaller) {
    return RailBooking(
      old.idDepCart,
      old.idretCart,
      old.departPrice,
      old.returnPrice,
      old.estimatedTotalPrice,
      dataCaller,
      [],
      []
    );
  }

  static copyWithPassenger(RailBooking old, List<Passenger> adults) {
    return RailBooking(
      old.idDepCart,
      old.idretCart,
      old.departPrice,
      old.returnPrice,
      old.estimatedTotalPrice,
      old.dataCaller,
      adults,
      []
    );
  }

  static RailBooking fromScheduleAndPassengers(RailBooking old, int adult, int child) {
    return RailBooking(
      old.idDepCart,
      old.idretCart,
      old.departPrice,
      old.returnPrice,
      old.estimatedTotalPrice,
      DataCaller.empty(),
      List.generate(adult + child, (index) => Passenger.empty(index+1)),
      List.generate(child, (index) => Passenger.empty(index+1))
    );
  }
}

class RailBookingRepository extends HiveRepository<RailBooking> {

  static String currentID = "CURRENT_ID";

  @override
  RailBooking deserialize(String json) => RailBooking.deserialize(json);

  @override
  String serialize(RailBooking t) => RailBooking.serialize(t);

}
