import 'package:kai_wisata/flights/models/passengers/flight_passenger_model.dart';

class FlightContactModel {
  String? idSchDep;
  String? idSchRet;
  String? contactTitle;
  String? contactFirstName;
  String? contactLastName;
  String? contactCountryCode;
  String? contactAreaCode;
  String? contactPhoneNumber;
  String? contactInsurance;
  String? contactEmail;
  List<FlightPassengerModel>? paxDetails;

  FlightContactModel({
    this.idSchDep,
    this.idSchRet,
    this.contactTitle,
    this.contactFirstName,
    this.contactLastName,
    this.contactCountryCode,
    this.contactAreaCode,
    this.contactPhoneNumber,
    this.contactInsurance,
    this.contactEmail,
    this.paxDetails,
  });

  FlightContactModel.fromJson(Map<String, dynamic> json) {
    idSchDep = json["id_schedule_departure"];
    idSchRet = json["id_schedule_return"];
    contactTitle = json["contact_title"];
    contactFirstName = json["contact_first_name"];
    contactLastName = json["contact_last_name"];
    contactCountryCode = json["contact_country_code_phone"];
    contactAreaCode = json["contact_area_code_phone"];
    contactPhoneNumber = json["contact_remaining_phone"];
    contactInsurance = json["insurance"];
    contactEmail = json["contact_email"];
    paxDetails = json['pax_details'] != null ? json['pax_details'].map<FlightPassengerModel>((passenger) => FlightPassengerModel.fromJson(passenger)).toList() : [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_schedule_departure': idSchDep,
      'id_schedule_return': idSchRet,
      'contact_title': contactTitle,
      'contact_first_name': contactFirstName,
      'contact_last_name': contactLastName,
      'contact_country_code_phone': contactCountryCode,
      'contact_area_code_phone': contactAreaCode,
      'contact_remaining_phone': contactPhoneNumber,
      'contact_email': contactEmail,
      'insurance': contactInsurance,
      'pax_details': paxDetails?.map((pax) => pax.toJson()).toList(),
    };
  }
}

class UninitializedFlightContactModel extends FlightContactModel {}
