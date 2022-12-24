import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

import '../../data/cache/hive_repository.dart';

class DataCallerCart {
  String title;
  String name;
  String phone;

  DataCallerCart(this.title, this.name, this.phone);
  
  factory DataCallerCart.fromJson(Map<String, dynamic> json){
    return DataCallerCart(
      json["title"],
      json["name"],
      json["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'name': name,
    'phone' : "0" + phone,
  };

  @override
  String toString(){
    return title == ""? name : "$title $name";
  }

  static DataCallerCart empty() {
    return DataCallerCart("", "", "");
  }
}

class PassengerCart {
  int id;
  String title;
  String name;
  String identity;
  String src;

  PassengerCart(this.id, this.title, this.name, this.identity, this.src);

  @override
  String toString(){
    return title == ""? name : "$title $name";
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'identity': identity
  };
  
  factory PassengerCart.fromJson(Map<String, dynamic> json){
    return PassengerCart(
        1,
        "Tuan",
        json['name'],
        json['identity'],
        "KTP/SIM"
    );
  }

  static List<PassengerCart> listFromJson(List<dynamic> json) {
    return json.map((e) => PassengerCart.fromJson(e)).toList();
  }

  static PassengerCart empty(int idx) {
    return PassengerCart(idx, "", "", "", "");
  }
}

class RailBookingCart extends KaiObject{
  String org;
  String des;
  DateTime departureDate;
  DateTime returnDate;
  DateTime arrivalDate;
  String transportNo;
  String transportClass;
  String subClass;
  int vendorId;
  String adultFare;
  String adultDiscountedPrice;
  String infantFare;
  String infantDiscountedPrice;
  DataCallerCart dataCallerCart;
  List<PassengerCart> adults;
  List<PassengerCart> infants;

  RailBookingCart(this.org, this.des, this.departureDate, this.returnDate, this.arrivalDate, this.transportNo, this.transportClass,
      this.subClass, this.vendorId, this.adultFare, this.adultDiscountedPrice, this.infantFare, this.infantDiscountedPrice, this.dataCallerCart, this.adults, this.infants);

  get departHour => DateFormat("HH:mm").format(departureDate);
  get arrivHour => DateFormat("HH:mm").format(arrivalDate);

  String getShortWeekDay(DateTime date){
    return ["", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"][date.weekday];
  }

  String get shortFromDate => getShortWeekDay(departureDate) + ", " + DateFormat("dd MMM").format(departureDate);

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

  static List<RailBookingCart> listFromJson(List<Map<String, dynamic>> json) =>
      json.map((e) => RailBookingCart.fromJson(e)).toList();

  static List<Map<String, dynamic>> toJsonList(List<RailBookingCart> bookings) =>
    bookings.map((e) => e.toJson()).toList();

  factory RailBookingCart.fromJson(Map<String, dynamic> json){
    return RailBookingCart(
        json['org'],
        json['des'],
        parseDate(json['dep_date']),
        parseDate(json['ret_date']),
        DateTime.now(),
        json['transporter_no'],
        json['transporter_class'],
        json['subclass'],
        json['vendor_id'],
        json['adult_price'],
        json['adult_discounted_price'],
        json['infant_price'],
        json['infant_discounted_price'],
        DataCallerCart.fromJson(json['data_caller']),
        PassengerCart.listFromJson(json["passenger_adult"]),
        PassengerCart.listFromJson(json["passenger_infant"]),
    );
  }
  
  Map<String, dynamic> toJson() => {
    "data_schedule_depart": {
      'origin': org,
      'destination': des,
      'departure_date' : DateFormat("yyyyMMdd").format(departureDate),
      'transporter_no' : transportNo,
      'transporter_class': transportClass,
      "transporter_sub_class" : subClass,
      "vendor_id" : vendorId,
      "adult_price": adultFare,
      "adult_discounted_price": adultDiscountedPrice,
      "infant_price": infantFare,
      "infant_discounted_price": infantDiscountedPrice,
    },
    "data_schedule_return": {
      'origin': des,
      'destination': org,
      'return_date' : DateFormat("yyyyMMdd").format(departureDate),
      'transporter_no' : transportNo,
      'transporter_class': transportClass,
      "transporter_sub_class" : subClass,
      "vendor_id" : vendorId,
      "adult_price": adultFare,
      "adult_discounted_price": adultDiscountedPrice,
      "infant_price": infantFare,
      "infant_discounted_price": infantDiscountedPrice,
    },
    "data_pax" : {
      "adult": adults.length,
      "infant": infants.length,
    },
  };
  Map<String, dynamic> toJsonPassenger() => {
    "data_contact" : dataCallerCart.toJson(),
    "data_passenger" : {
      "adult": adults.map((e) => e.toJson()).toList(),
      "infant": infants.map((e) => e.toJson()).toList(),
    },
  };

  static RailBookingCart deserialize(String str) => RailBookingCart.fromJson(jsonDecode(str));
  static String serialize(RailBookingCart t) => jsonEncode(t.toJson());

  @override
  String getId() {
    return "$org-$des-${DateFormat("ddMMyyyy").format(departureDate)}";
  }

  static RailBookingCart fromSchedule(RailSchedule schedule) {
    return RailBookingCart(
        schedule.origin,
        schedule.destination,
        schedule.departureTime,
        schedule.returnTime,
        schedule.arrivalTime,
        schedule.transporterNo,
        schedule.kelas,
        schedule.subClass,
        schedule.vendorId,
        schedule.adultFare.toString(),
        schedule.adultDiscount.toString(),
        schedule.infantFare.toString(),
        schedule.infantDiscount.toString(),
        DataCallerCart.empty(),
        [],
        []
    );
  }

  static copyWithDataCallerCart(RailBookingCart old, DataCallerCart dataCallerCart) {
    return RailBookingCart(
        old.org,
        old.des,
        old.departureDate,
        old.returnDate,
        old.arrivalDate,
        old.transportNo,
        old.transportClass,
        old.subClass,
        old.vendorId,
        old.adultFare,
        old.adultDiscountedPrice,
        old.infantFare,
        old.infantDiscountedPrice,
        old.dataCallerCart,
        [],
        []
    );
  }

  static copyWithPassenger(RailBookingCart old, List<PassengerCart> adults) {
    return RailBookingCart(
        old.org,
        old.des,
        old.departureDate,
        old.returnDate,
        old.arrivalDate,
        old.transportNo,
        old.transportClass,
        old.subClass,
        old.vendorId,
        old.adultFare,
        old.adultDiscountedPrice,
        old.infantFare,
        old.infantDiscountedPrice,
        old.dataCallerCart,
        adults,
        []
    );
  }

  static RailBookingCart fromScheduleAndPassengers(RailSchedule schedule, int adult, int child) {
    return RailBookingCart(
        schedule.origin,
        schedule.destination,
        schedule.departureTime,
        schedule.returnTime,
        schedule.arrivalTime,
        schedule.transporterNo,
        schedule.kelas,
        schedule.subClass,
        schedule.vendorId,
        schedule.adultFare.toString(),
        schedule.adultDiscount.toString(),
        schedule.infantFare.toString(),
        schedule.infantDiscount.toString(),
        DataCallerCart.empty(),
        List.generate(adult + child, (index) => PassengerCart.empty(index+1)),
        List.generate(child, (index) => PassengerCart.empty(index+1))
    );
  }
}

class RailBookingCartRepository extends HiveRepository<RailBookingCart> {

  static String currentID = "CURRENT_ID";

  @override
  RailBookingCart deserialize(String json) => RailBookingCart.deserialize(json);

  @override
  String serialize(RailBookingCart t) => RailBookingCart.serialize(t);

}
