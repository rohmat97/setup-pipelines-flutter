import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:kai_wisata/base_service.dart';
import 'package:kai_wisata/flights/arguments/flight_result_arguments.dart';
import 'package:kai_wisata/flights/models/addon/flight_addon_model.dart';
import 'package:kai_wisata/flights/models/contacts/flight_contact_model.dart';
import 'package:kai_wisata/flights/models/doku/flight_payment_model.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/flights/models/flight_booking_model.dart';
import 'package:kai_wisata/flights/models/flight_detail_model.dart';
import 'package:kai_wisata/flights/models/flight_payment_method_model.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightService extends BaseService {
  static Future<dynamic> getAllAirports() async {
    String endPoint = "/api/flight/airport_all";

    var json = await BaseService.get(endPoint);

    if (json['success'] == true) {
      List<AirportsModel> airports = [];

      for (var ap in json["data"]) {
        airports.add(AirportsModel.fromJson(ap));
      }

      return airports;      
    } else {
      throw Exception(json);
    }
  }
  Future<List<AirportsModel>> airports(String? search) async {
    String endPoint = "/api/flight/airport_all";

    Map<String, String> params = {
      "search": search!,
    };

    var json = await BaseService.getWithParams(endPoint, params);

    if (json['success'] == true) {
      List data = json['data'];

      return data.map((e) => AirportsModel.fromJson(e)).where((airport) {
        final name = airport.airportName!.toLowerCase();
        final code = airport.airportCode!.toLowerCase();
        final city = airport.airportCity!.toLowerCase();
        final country = airport.airportCountry!.toLowerCase();
        final queryLower = search.toLowerCase();

        return name.contains(queryLower) || code.contains(queryLower) || city.contains(queryLower) || country.contains(queryLower);
      }).take(10).toList();
    } else {
      throw Exception(json);
    }
  }

  Future<FlightResultModel> getScheduleAll({
    String? fromAirport,
    String? toAirport,
    DateTime? dateFrom,
    DateTime? dateTo,
    int? adult,
    int? child,
    int? infant,
    String? tripType,
    String? accCode,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String endPoint = "/api/flight/get_schedule_all";

    Map<String, dynamic> params = {
      "trip_type": tripType,
      "org": fromAirport,
      "des": toAirport,
      "departure_date": DateFormat("yyyy-MM-dd").format(dateFrom!),
      "return_date": tripType == "OneWay" ? "" : DateFormat("yyyy-MM-dd").format(dateTo!),
      "pax_adult": adult,
      "pax_child": child,
      "pax_infant": infant,
      "page": 1,
      "per_page": 10,
      "sort_by": "id",
      "order": "asc",
      "access_code": accCode,
    };
    print(params);

    var response = await BaseService.post(endPoint, params);
    // print(response);

    if (response['success'] == true) {
      FlightResultModel result = FlightResultModel.fromJson(response);

      return result;
    } else {
      await prefs.setString("image_encoded", response['image_encoded'] ?? '');
      // throw Exception(response["success"]);
      FlightResultModel result = FlightResultModel.fromJson(response);

      return result;
    }
  }

  Future<FlightDetailModel> getScheduleDetail({
    String? idScheduleDepart,
    String? idScheduleReturn,
    String? accCode,
  }) async {
    String endPoint = "/api/flight/get_schedule_detail";

    Map<String, dynamic> params = {
      "id_schedule_departure": idScheduleDepart,
      "id_schedule_return": idScheduleReturn,
      "access_code": accCode,
    };
    print(json.encode(params));

    var response = await BaseService.post(endPoint, params);
    // print(json.encode(response));

    if (response['success'] == true) {
      FlightDetailModel result = FlightDetailModel.fromJson(response);

      return result;
    } else {
      FlightDetailModel result = FlightDetailModel.fromJson(response);

      return result;
    }
  }

  Future<dynamic> getAddOn(FlightContactModel contact) async {
    String endPoint = "/api/flight/get_add_on";

    Map<String, dynamic> params = contact.toJson();
    // print(params.toString());
    // debugPrint(json.encode(params));
    // dev.log('Add ons', name: 'add on');
    myLongPrint(json.encode(params));

    var response = await BaseService.post(endPoint, params);
    print(json.encode(response));

    if (response['success'] == true) {
      List<FlightAddOnModel> addOns = [];
      for (var baggageAddOn in response["data"]["baggageAddOns"]) {
        addOns.add(FlightAddOnModel.fromJson(baggageAddOn));
      }

      return addOns;
    } else {
      throw Exception(response);
    }
  }

  Future<dynamic> booking({
    String? idScheduleDepart,
    String? idScheduleReturn,
  }) async {
    String endPoint = "/api/flight/booking";

    Map<String, dynamic> params = {
      "id_schedule_departure": idScheduleDepart,
      "id_schedule_return": idScheduleReturn,
    };

    var response = await BaseService.post(endPoint, params);
    print(response);

    if (response['success'] == true) {
      FlightBookingModel booking = FlightBookingModel.fromJson(response["data"]);

      return booking;
    } else {
      throw Exception(response);
    }
  }

  Future<dynamic> getPaymentMethod() async {
    String endPoint = "/api/payment/method-list";
    var response = await BaseService.get(endPoint);

    if (response['success'] == true) {
      List<FlightPaymentMethodModel> payments = [];
      for (var pm in response["data"]) {
        payments.add(FlightPaymentMethodModel.fromJson(pm));
      }

      return payments;
    } else {
      throw Exception(response);
    }
  }

  Future<dynamic> payDoku(Map<String, dynamic> reqDoku) async {
    String endPoint = "/api/payment/generateVA";

    Map<String, dynamic> params = reqDoku;

    var response = await BaseService.post(endPoint, params);

    if (response['success'] == true) {
      FlightPaymentModel payment = FlightPaymentModel.fromJson(response);

      return payment;
    } else {
      throw Exception(response);
    }
  }

  void myLongPrint(input) {
    String str = input.toString();

    // print out each chunk of 1000 characters sequentially
    while (str.length > 1000) {
      debugPrint(str.substring(0, 1000));

      // remove the first 1000 characters
      str = str.substring(1000);
    }
    
    // print the remaining characters
    debugPrint(str);
  }
}