enum PaymentType {
  prePaid,
  postPaid,
}

class Brand {
  final PaymentType paymentType;
  final String brand;

  Brand(this.paymentType, this.brand);

  factory Brand.fromJson(json){
    String strType = json["payment_type"];
    PaymentType paymentType = strType == "PraBayar"
        ? PaymentType.prePaid
        : PaymentType.postPaid;
    return Brand(paymentType, json["brand"]);
  }

  static List<Brand> listFromJson(List<dynamic> json) => json.map((e) => Brand.fromJson(e)).toList();
}

