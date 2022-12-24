import 'dart:convert';

import 'package:kai_wisata/flights/models/flight_payment_method_model.dart';
import 'package:kai_wisata/kai_reguler/arguments/search_ticket_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';
import 'package:kai_wisata/base_service.dart';
import 'package:kai_wisata/kai_reguler/models/seats/seat_map.dart';

import 'search_station_response.dart';

import 'package:intl/intl.dart';

class RegularTicketService extends BaseService {
  static Future<SearchStationResponse> fetchStations() async {
    String endPoint = "/api/train/station_all";
    var json = await BaseService.get(endPoint);
    return SearchStationResponse.fromJson(json);
  }

  static Future<dynamic> getRailSchedule(
      SearchTicketArguments arg) async {

    String endPoint = "/api/train/get_schedule_all";

    Map<String, dynamic> params = {
      "org": arg.from!.code,
      "des": arg.to!.code,
      "departure_date": DateFormat('yyyy-MM-dd').format(arg.fromDate!),
      "return_date": DateFormat('yyyy-MM-dd').format(arg.toDate!),
      "pax_adult": "${arg.adult + arg.child}",
      "pax_infant": "${arg.baby}",
      "page": 1,
      "per_page": 10,
      "sort_by": "id",
      "order": "asc"
    };

    
    var json = await BaseService.post(endPoint, params);
    print(json);
    List<RailSchedule> schedules = [];

    List<dynamic> listSchedules = json["data"]["departure"];
    for (Map<String, dynamic> schedule in listSchedules) {
      schedules.add(RailSchedule.fromJson(schedule));
    }

    return schedules;
  }

  static Future<dynamic> bookCart(RailBookingCart bookingCart) async {
    String url = "/api/train/booking_cart";
    var json = await BaseService.post(url, bookingCart.toJson());
    // print(json);
    return json["data"];
  }

  static Future<dynamic> book(Map<String, dynamic> booking) async {
    String url = "/api/train/booking";
    var json = await BaseService.post(url, booking);
    print(json);
    return json["data"];
  }

  static Future<dynamic> getBookingInfo(String bookingCode) async {
    String endPoint = "/api/train/booking_detail";
    Map<String, dynamic> params = {
      "booking_code": bookingCode,
    };
    var json = await BaseService.post(endPoint, params);
    print(json);
    return RailBookingInfo.fromJson(json["data"]);
  }

  static Future<dynamic> getBookingDetail(String bookingCode) async {
    String endPoint = "/api/train/booking_detail";
    Map<String, dynamic> params = {
      "booking_code": bookingCode,
    };
    var json = await BaseService.post(endPoint, params);
    print(json);
    return json["data"];
  }

  static Future<dynamic> getSeatMap(String bookingCode) async {
    String endPoint = "/api/train/seat_map";
    Map<String, dynamic> params = {
      "booking_code": bookingCode,
    };
    var json = await BaseService.post(endPoint, params);
    // print(json);
    return SeatMap.fromJson(json);
  }

  static Future<dynamic> changedSeatMap(Map<String, dynamic> chSeatMap) async {
    String endPoint = "/api/train/change_seat";
    Map<String, dynamic> params = chSeatMap;
    var json = await BaseService.post(endPoint, params);
    print(json);
    return json;
  }

  static Future<dynamic> paymentMethods() async {
    String endPoint = "/api/payment/method-list";
    var json = await BaseService.get(endPoint);
    print(json);

    if (json["success"]) {
      List<FlightPaymentMethodModel> payments = [];

      for (var pm in json["data"]) {
        payments.add(FlightPaymentMethodModel.fromJson(pm));
      }

      return payments;
    } else {
      throw Exception(json);
    }
  }

  static Future<String> createPayment(Map<String, dynamic> trxObj) async{
    String url = "/api/payment/generateVA";
    var params = trxObj;
    var json = await BaseService.post(url, params);
    print(json);
    return json["data"]["virtual_account_info"]["how_to_pay_page"];
  }
}