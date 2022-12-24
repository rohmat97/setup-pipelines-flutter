import 'dart:convert';

import 'package:kai_wisata/flights/models/flight_schedule_model.dart';

class FlightResultErrorModel {
  bool? success;
  String? message;
  String? image;
  
  FlightResultErrorModel({
    this.success,
    this.message,
    this.image,
  });

  FlightResultErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    image = json["image_encoded"];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'image_encoded': image,
    };
  }
}

class UninitializedFlightResultErrorModel extends FlightResultErrorModel {}