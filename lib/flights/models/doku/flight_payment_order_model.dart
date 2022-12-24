class FlightPaymentOrderModel {
  String? invoiceNumber;
  String? amount;
  
  FlightPaymentOrderModel({
    this.invoiceNumber,
    this.amount,
  });

  FlightPaymentOrderModel.fromJson(Map<String, dynamic> json) {
    invoiceNumber = json['invoice_number'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'invoice_number': invoiceNumber,
      'amount': amount,
    };
  }
}

class UninitializedFlightPaymentOrderModel extends FlightPaymentOrderModel {}