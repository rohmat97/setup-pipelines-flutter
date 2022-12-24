import 'package:kai_wisata/flights/models/flight_schedule_model.dart';

class FlightBookingModel {
  int? transactionId;
  String? bookingDate;
  String? bookingCode;
  DateTime? timeLimit;
  double? airlineAdminFee;
  double? memberAdminFee;
  double? memberDiscount;
  double? salesPrice;
  double? ticketPrice;
  String? currency;
  String? detail;
  
  FlightBookingModel({
    this.transactionId,
    this.bookingDate,
    this.bookingCode,
    this.timeLimit,
    this.airlineAdminFee,
    this.memberAdminFee,
    this.memberDiscount,
    this.salesPrice,
    this.ticketPrice,
    this.currency,
    this.detail,
  });

  FlightBookingModel.fromJson(Map<String, dynamic> json) {
    transactionId = json["transaction_id"];
    bookingDate = json["booking_date"];
    bookingCode = json["booking_code"];
    timeLimit = DateTime.parse(json["time_limit"]);
    airlineAdminFee = double.parse(json["airline_admin_fee"].toString());
    memberAdminFee = double.parse(json["member_admin_fee"].toString());
    memberDiscount = double.parse(json["member_discount"].toString());
    salesPrice = double.parse(json["sales_price"].toString());
    ticketPrice = double.parse(json["ticket_Price"].toString());
    currency = json["currency"];
    detail = json["detail"];
  }

  Map<String, dynamic> toJson() {
    return {
      "transaction_id": transactionId,
      "booking_date": bookingDate,
      "booking_code": bookingCode,
      "time_limit": timeLimit?.toString(),
      "airline_admin_fee": airlineAdminFee,
      "member_admin_fee": memberAdminFee,
      "member_discount": memberDiscount,
      "sales_price": salesPrice,
      "ticket_Price": ticketPrice,
      "currency": currency,
      "detail": detail,
    };
  }
}

class UninitializedFlightBookingModel extends FlightBookingModel {}