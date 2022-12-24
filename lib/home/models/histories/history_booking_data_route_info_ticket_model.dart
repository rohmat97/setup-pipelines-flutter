import 'package:intl/intl.dart';

class HistoryBookingDataRouteInfoTicketModel {
  String? name;
  String? seat;
  
  HistoryBookingDataRouteInfoTicketModel({
    this.name,
    this.seat,
  });

  HistoryBookingDataRouteInfoTicketModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    seat = json["seat"];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'seat': seat,
    };
  }
}

class UninitializedHistoryBookingDataRouteInfoTicketModel extends HistoryBookingDataRouteInfoTicketModel {}
