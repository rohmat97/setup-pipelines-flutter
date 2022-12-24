import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';

class AirportCache {
  Box? box;
  AirportCache._privateConstructor();

  Future<void> init() async {
    box = await Hive.openBox<void>((AirportCache).toString());
  }

  static final AirportCache _instance = AirportCache._privateConstructor();
  static AirportCache get instance => _instance;

  void saveAirports(List<AirportsModel> airports){
    box?.put("list_airports", json.encode(airports));
  }

  List<AirportsModel>? getAirports(){
    var json = box?.get("list_airports");
    return json;
    // return json == "" ? null: List<AirportsModel>.from(jsonDecode(json));
  }
}