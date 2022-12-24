import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/caches/airport_cache.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

class FlightAirportsState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  List<AirportsModel> airports = [];
  late AirportsModel _airport;

  AirportsModel get bandara => _airport;

  final LocalStorage storage = LocalStorage('flight_data');

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  set postal(AirportsModel bandara) {
    _airport = bandara;
    notifyListeners();
  }

  void onBackButton() {
    Navigator.pop(context!);
  }
}