import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/arguments/flight_doku_arguments.dart';
import 'package:kai_wisata/flights/caches/airport_cache.dart';
import 'package:kai_wisata/flights/models/doku/flight_payment_model.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';
import 'package:kai_wisata/flights/models/flight_booking_model.dart';
import 'package:kai_wisata/flights/models/flight_payment_method_model.dart';
import 'package:kai_wisata/flights/pages/flight_doku_page.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

class FlightBookingState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  FlightBookingModel? _booking;
  FlightBookingModel? get booking => _booking;

  List<FlightPaymentMethodModel> _payments = [];
  List<FlightPaymentMethodModel> get payments => _payments;

  FlightPaymentModel? _payment;
  FlightPaymentModel? get payment => _payment;

  String? urlPayPage;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  set booking(FlightBookingModel? booking) {
    _booking = booking;
    notifyListeners();
  }

  set payments(List<FlightPaymentMethodModel> payments) {
    _payments = payments;
    notifyListeners();
  }

  set payment(FlightPaymentModel? payment) {
    _payment = payment;
    notifyListeners();
  }

  void setUrlPayPage(String urlPayPage){
    urlPayPage = urlPayPage;

    notifyListeners();
  }

  Future<bool> bookings(String? idscdep, String? idscret) async {
    try {
      FlightBookingModel booking = await FlightService().booking(idScheduleDepart: idscdep, idScheduleReturn: idscret);

      _booking = booking;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getPaymentMethod() async {
    try {
      List<FlightPaymentMethodModel> payments = await FlightService().getPaymentMethod();

      _payments = payments;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> payDoku(Map<String, dynamic> reqDoku) async {
    try {
      FlightPaymentModel payment = await FlightService().payDoku(reqDoku);
      urlPayPage = payment.virtualAccountInfo!.howtopage;

      _payment = payment;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void onNextButton() {
    Navigator.pushNamed(context!, FlightDokuPage.routeName, arguments: flightDokuArguments());
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onBackHome() {
    Navigator.pushNamedAndRemoveUntil(context!, HomePage.routeName, (Route<dynamic> route) => false);
  }

  FlightDokuArguments flightDokuArguments() {
    return FlightDokuArguments(urlPayPage, payment);
  }
}