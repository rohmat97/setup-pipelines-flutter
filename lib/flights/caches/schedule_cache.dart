import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';

class ScheduleCache {
  Box? box;
  ScheduleCache._privateConstructor();

  Future<void> init() async {
    box = await Hive.openBox<void>((ScheduleCache).toString());
  }

  static final ScheduleCache _instance = ScheduleCache._privateConstructor();
  static ScheduleCache get instance => _instance;

  void saveSchedules(FlightResultModel result){
    // print(result);
    box?.put("schedules", result.toJson());
  }

  FlightResultModel? getSchedules(){
    var json = box?.get("schedules");
    
    return json == "" ? null: FlightResultModel.fromJson(jsonDecode(json));
  }
}