import 'package:intl/intl.dart';

class DokuPaymentModel {
  /*
  {
    code: 200, 
    success: true, 
    message: success, 
    data: {
      order: {
        invoice_number: DVL202212200022, amount: 79278.00},
        virtual_account_info: {
          virtual_account_number: 1900800000024391, 
          how_to_pay_page: https://sandbox.doku.com/how-to-pay/v2/bca-virtual-account/1900800000024391/zq_cMv2sUF7wY8sHcAJUY5XRJEEA54Ik5L8DfMm0R5g, 
          how_to_pay_api: https://api-sandbox.doku.com/bca-virtual-account/v2/how-to-pay-api/1900800000024391/zq_cMv2sUF7wY8sHcAJUY5XRJEEA54Ik5L8DfMm0R5g, 
          created_date: 20221220161644, 
          expired_date: 20221220171644, 
          created_date_utc: 2022-12-20T09:16:44Z, 
          expired_date_utc: 2022-12-20T10:16:44Z, 
          virtual_account_name: BCA Virtual Account
        }
      }
    }
  */

  final String invoiceNumber;
  final int amount;
  final int virtualAccountNumber;
  final String url;
  final int expireDate;
  final DateTime expireDateUtc;
  final String virtualAccountName;

  DokuPaymentModel({
    required this.invoiceNumber,
    required this.amount,
    required this.virtualAccountNumber,
    required this.url,
    required this.expireDate,
    required this.expireDateUtc,
    required this.virtualAccountName,
  });

  static DateTime toDateTime(String str) {
    var params = str.split("T");
    var hours = params[1].trim().split(":");

    var dateParams = params[0].split("-");
    return DateTime(
        int.parse(dateParams[2]),
        int.parse(dateParams[1]),
        int.parse(dateParams[0]),
        int.parse(hours[0]),
        int.parse(hours[1]),
        0,
        0,
        0);
  }

  factory DokuPaymentModel.fromJson(Map<String, dynamic> json) {
    return DokuPaymentModel(
      invoiceNumber: json["order"]["invoice_number"],
      amount: json["order"]["amount"],
      virtualAccountNumber: json["virtual_account_info"]
          ["virtual_account_number"],
      url: json["virtual_account_info"]["how_to_pay_page"],
      expireDate: json["virtual_account_info"]["expired_date"],
      expireDateUtc:
          toDateTime(json["virtual_account_info"]["expired_date_utc"]),
      virtualAccountName: json["virtual_account_info"]["virtual_account_name"],
    );
  }
}
