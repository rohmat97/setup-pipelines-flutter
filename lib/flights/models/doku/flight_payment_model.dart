import 'package:kai_wisata/flights/models/doku/flight_payment_order_model.dart';
import 'package:kai_wisata/flights/models/doku/flight_payment_va_model.dart';

class FlightPaymentModel {
  int? code;
  bool? success;
  String? message;
  FlightPaymentOrderModel? order;
  FlightPaymentVaModel? virtualAccountInfo;
  
  FlightPaymentModel({
    this.code,
    this.success,
    this.message,
    this.order,
    this.virtualAccountInfo,
  });

  FlightPaymentModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
    order = FlightPaymentOrderModel.fromJson(json["data"]["order"]);
    virtualAccountInfo = FlightPaymentVaModel.fromJson(json["data"]["virtual_account_info"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'success': success,
      'message': message,
      'order': order?.toJson(),
      'virtual_account_info': virtualAccountInfo?.toJson(),
    };
  }
}

class UninitializedFlightPaymentModel extends FlightPaymentModel {}