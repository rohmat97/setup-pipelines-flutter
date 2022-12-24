import 'package:intl/intl.dart';

class HistoryBookingPaymentModel {
  int? transactionId;
  String? vaNumber;
  String? paymentChannel;
  
  HistoryBookingPaymentModel({
    this.transactionId,
    this.vaNumber,
    this.paymentChannel,
  });

  HistoryBookingPaymentModel.fromJson(Map<String, dynamic> json) {
    transactionId = json["transaction_id"];
    vaNumber = json["va_number"];
    paymentChannel = json["payment_channel"];
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'va_number': vaNumber,
      'payment_channel': paymentChannel,
    };
  }
}

class UninitializedHistoryBookingPaymentModel extends HistoryBookingPaymentModel {}
