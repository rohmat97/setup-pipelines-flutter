import 'package:kai_wisata/flights/models/details/flight_journer_return_model.dart';
import 'package:kai_wisata/flights/models/details/flight_journey_departure_model.dart';

class FlightDetailModel {
  bool? success;
  String? message;
  String? airline;
  String? airlineCode;
  String? origin;
  String? destination;
  String? image;
  List<FlightJourneyDepartureModel>? departure;
  List<FlightJourneyReturnModel>? returnee;
  
  FlightDetailModel({
    this.success,
    this.message,
    this.airline,
    this.airlineCode,
    this.origin,
    this.destination,
    this.image,
    this.departure,
    this.returnee,
  });

  FlightDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    airline = json["data"] != null ? json["data"]['airline'] : null;
    airlineCode = json["data"] != null ? json["data"]['airline_code'] : null;
    origin = json["data"] != null ? json["data"]['origin'] : null;
    destination = json["data"] != null ? json["data"]['destination'] : null;
    image = json['image_encoded'];
    departure = json["data"] == null ? null : json["data"]['journey_departure'].map<FlightJourneyDepartureModel>((depart) => FlightJourneyDepartureModel.fromJson(depart)).toList();
    returnee = json["data"] == null ? null : (json["data"]['journey_return'] == null ? [] : json["data"]['journey_return'].map<FlightJourneyReturnModel>((returning) => FlightJourneyReturnModel.fromJson(returning)).toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'airline': airline,
      'airline_code': airlineCode,
      'origin': origin,
      'destination': destination,
      'image_encoded': image,
      'journey_departure': departure?.map((depart) => depart.toJson()).toList(),
      'journey_return': returnee?.map((returning) => returning.toJson()).toList(),
    };
  }
}

class UninitializedFlightDetailModel extends FlightDetailModel {}