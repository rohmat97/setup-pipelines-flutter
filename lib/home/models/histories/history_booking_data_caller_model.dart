import 'package:intl/intl.dart';

class HistoryBookingDataCallerModel {
  String? title;
  String? name;
  String? phone;
  
  HistoryBookingDataCallerModel({
    this.title,
    this.name,
    this.phone,
  });

  HistoryBookingDataCallerModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    name = json["name"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'name': name,
      'phone': phone,
    };
  }
}

class UninitializedHistoryBookingDataCallerModel extends HistoryBookingDataCallerModel {}
