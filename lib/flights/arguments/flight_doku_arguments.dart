import 'package:kai_wisata/flights/models/doku/flight_payment_model.dart';

class FlightDokuArguments {
  final String? url;
  final FlightPaymentModel? payment;

  FlightDokuArguments(this.url, this.payment);

  static FlightDokuArguments empty() {
    return FlightDokuArguments(
      '',
      null,
    );
  }

  factory FlightDokuArguments.fromJson(Map<String, dynamic> json){
    return FlightDokuArguments(
      json["url"],
      json["payment"],
    );
  }
}