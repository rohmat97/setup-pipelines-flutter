import 'package:kai_wisata/flights/models/flight_schedules_model.dart';

class FlightScheduleModel {
  List<FlightSchedulesModel>? departures;
  List<FlightSchedulesModel>? returns;

  FlightScheduleModel({
    this.departures,
    this.returns,
  });

  FlightScheduleModel.fromJson(Map<String, dynamic> json) {
    departures = json['departure'][0].map<FlightSchedulesModel>((departure) => FlightSchedulesModel.fromJson(departure)).toList() ?? [];
    returns = json['return'].isEmpty ? [] : json['return'][0].map<FlightSchedulesModel>((returns) => FlightSchedulesModel.fromJson(returns)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'departure': departures?.map((departure) => departure.toJson()).toList(),
      'return': returns?.map((returnee) => returnee.toJson()).toList(),
    };
  }
}
