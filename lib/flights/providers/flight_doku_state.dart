import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/arguments/flight_doku_arguments.dart';
import 'package:kai_wisata/flights/caches/airport_cache.dart';
import 'package:kai_wisata/flights/models/doku/flight_payment_model.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';
import 'package:kai_wisata/flights/models/flight_booking_model.dart';
import 'package:kai_wisata/flights/models/flight_payment_method_model.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

class FlightDokuState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  FlightDokuArguments? args;

  FlightPaymentModel? _payment;
  FlightPaymentModel? get payment => _payment;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
    FlightDokuArguments args,
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  set payment(FlightPaymentModel? payment) {
    _payment = payment;
    notifyListeners();
  }

  Future<bool> payDoku(Map<String, dynamic> reqDoku) async {
    try {
      FlightPaymentModel payment = await FlightService().payDoku(reqDoku);
      print(payment);

      _payment = payment;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void onBackButton() {
    Navigator.pushNamedAndRemoveUntil(context!, HomePage.routeName, (Route<dynamic> route) => false);
  }

  void onBackHome() {
    Navigator.pop(context!);
    Navigator.pushNamedAndRemoveUntil(context!, HomePage.routeName, (Route<dynamic> route) => false);
  }
}