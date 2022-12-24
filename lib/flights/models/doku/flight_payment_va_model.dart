class FlightPaymentVaModel {
  String? vaAccNum;
  String? howtopage;
  String? howtoapi;
  String? createdAt;
  String? expiredAt;
  String? vaAccName;
  
  FlightPaymentVaModel({
    this.vaAccNum,
    this.howtopage,
    this.howtoapi,
    this.createdAt,
    this.expiredAt,
    this.vaAccName,
  });

  FlightPaymentVaModel.fromJson(Map<String, dynamic> json) {
    vaAccNum = json["virtual_account_number"];
    howtopage = json["how_to_pay_page"];
    howtoapi = json["how_to_pay_api"];
    createdAt = json["created_date"];
    expiredAt = json["expired_date"];
    vaAccName = json["virtual_account_name"];
  }

  Map<String, dynamic> toJson() {
    return {
      "virtual_account_number": vaAccNum,
      "how_to_pay_page": howtopage,
      "how_to_pay_api": howtoapi,
      "created_date": createdAt,
      "expired_date": expiredAt,
      "virtual_account_name": vaAccName,
    };
  }
}

class UninitializedFlightPaymentVaModel extends FlightPaymentVaModel {}