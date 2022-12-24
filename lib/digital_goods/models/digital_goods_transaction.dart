import 'package:intl/intl.dart';

class DigitalGoodsTransaction {
  /*
  "httpgetx_xid": "40wx48kolbryk30u",
        "command": "INQUIRY",
        "request_id": "13881",
        "transaction_id": "15058906",
        "transaction_date": "2022-12-17T11:30:52.000Z",
        "store_name": "Gowisata",
        "terminal_name": "gowisata@108.137.124.108",
        "product_name": "PLN PASCABAYAR",
        "destination": "538612750005",
        "rc": "00",
        "sn": "CUSTID:538612750005/NAMA:CHRISTIONO-HENDRAWAN/PERIODE:202212/TAGIHAN:77378/ADM:2750",
        "message": "Cek tagihan PLN PASCABAYAR untuk 538612750005 pada tanggal 2022-12-17 18:30:52 SUKSES. DETAIL=CUSTID:538612750005/NAMA:CHRISTIONO-HENDRAWAN/PERIODE:202212/TAGIHAN:77378/ADM:2750. Saldo setelah transaksi Rp. 81.230. Saldo yg akan dipotong Rp. 79.278.",
        "amount": 0,
        "ending_balance": 81230,
        "amount_to_charge": 79278
  */

  final int userId;
  final String transactionType;
  final String invoiceNumber;
  final int id;
  final int total;

  DigitalGoodsTransaction(
      {required this.userId,
      required this.transactionType,
      required this.invoiceNumber,
      required this.id,
      required this.total});

  static DateTime toDateTime(String str) {
    var params = str.split("-");
    var hours = params[1].trim().split(":");

    var dateParams = params[0].split("/");
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

  factory DigitalGoodsTransaction.fromJson(Map<String, dynamic> json) {
    return DigitalGoodsTransaction(
      userId: json["user_id"],
      transactionType: json["transaction_type"],
      invoiceNumber: json["invoice_number"],
      id: json["id"],
      total: json["total"],
    );
  }
}
