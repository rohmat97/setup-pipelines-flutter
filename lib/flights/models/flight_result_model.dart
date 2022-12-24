import 'dart:convert';

import 'package:kai_wisata/flights/models/flight_schedule_model.dart';

class FlightResultModel {
  bool? success;
  String? message;
  String? image;
  FlightScheduleModel? schedules;
  
  FlightResultModel({
    this.success,
    this.message,
    this.image,
    this.schedules,
  });

  FlightResultModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    image = json["image_encoded"];
    schedules = json['data'] != null ? FlightScheduleModel.fromJson(json['data']['schedules']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'image_encoded': image,
      'schedules': schedules?.toJson(),
    };
  }
}

class UninitializedFlightResultModel extends FlightResultModel {}