import 'dart:convert';

import 'package:kai_wisata/kai_istimewa/models/special_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';

import '../../digital_goods/models/buy_info.dart';
import '../../home/models/history_payment.dart';
import '../../kai_reguler/models/rail_booking_info.dart';
import '../../kai_wisata/models/tourism_book_info.dart';

class Transaction {
  /*
  "transaction_date": "2022-08-28T13:36:51.552431",
      "response_message": "GAW, Pembelian XL 10.000 ke 08172347546 GAGAL. Tidak dapat melakukan debit pada saldo. Silahkan cek apakah saldo anda mencukupi. Harga Rp. 11.382.",
      "invoice_no": "INV/2022/E-GOODSXXX",
      "modified_at": "2022-08-28T13:38:08.904635",
      "transaction_type": "E-GOODS",
      "response_data": "{\"httpgetx_xid\": \"40wx4hc4l7ddmyjr\", \"request_id\": \"ccf44103-2cf0-48b7-96e7-1fd0ef4398ed\", \"store_name\": \"GAW\", \"product_name\": \"XL 10.000\", \"destination\": \"08172347546\", \"rc\": \"92\", \"amount\": 11382, \"message\": \"GAW, Pembelian XL 10.000 ke 08172347546 GAGAL. Tidak dapat melakukan debit pada saldo. Silahkan cek apakah saldo anda mencukupi. Harga Rp. 11.382.\"}",
      "payment_type": "DOKU",
      "modified_by": "endpoint callback doku",
      "transaction_description": "E-GOODS: XL 10.000 - 08172347546",
      "quantity": 1,
      "payment_date": "2022-08-28T13:38:08.747953",
      "transaction_data": "{\"product_code\": \"XL 10.000\", \"destination\": \"08172347546\", \"price\": 0}",
      "price": 0,
      "payment_status": "PAID",
      "transaction_cost_data": "{\"product_code\": \"XL 10.000\", \"destination\": \"08172347546\", \"price\": 0}",
      "additional_fee": 0,
      "payment_data": null,
      "id": "ccf44103-2cf0-48b7-96e7-1fd0ef4398ed",
      "transaction_expired": "2022-08-28 19:36:51.544686",
      "discount": 0,
      "created_at": "2022-08-28T13:36:51.552443",
      "userid": "d9ced960-6eaa-4471-b365-cdbd8f84bc5c",
      "response_code": "92",
      "total": 0,
      "created_by": "datu",
      "transaction_code": "E-GOODS-XL 10.000-[DATE]-[XXX]",
      "status": "FAILED"
   */

  final String id;
  final DateTime transactionDate;
  final String responseMessage;
  final String invoiceNo;
  final String transactionType;
  final String description;
  final String paymentStatus;
  final BookingStatus status;
  final String code;
  final String transactionData;

  Transaction(this.id, this.transactionDate, this.responseMessage,
      this.invoiceNo, this.transactionType, this.description,
      this.paymentStatus,
      this.status, this.code, this.transactionData);


  static BookingStatus statusFromString(String str) {
    switch (str) {
      case "PROCESSED" :
        return BookingStatus.processed;
      case "COMPLETED":
        return BookingStatus.completed;
      case "CANCELLED" :
        return BookingStatus.canceled;
      default :
        return BookingStatus.processed;
    }
  }

  factory Transaction.fromJson(json){
    return Transaction(
      json["id"],
      DateTime.parse(json["transaction_date"]),
      "",
      json["invoice_no"],
      json["transaction_type"],
      json["transaction_description"],
      json["payment_status"],
      statusFromString(json["status"]),
      json["transaction_code"],
      json["transaction_data"],
    );
  }

  BuyInfo get buyInfo => BuyInfo.fromJson(jsonDecode(transactionData));

  bool get isValid {
    try {
      jsonDecode(transactionData);
      return true;
    } catch (e) {
      return false;
    }
  }

  SpecialBookingInfo  get specialBookInfo => SpecialBookingInfo.fromJson(jsonDecode(transactionData));

  TourismBookInfo  get tourismBookInfo => TourismBookInfo.fromJson(jsonDecode(transactionData));

  RailBookingInfo get railBoookInfo =>
      RailBookingInfo.fromJson(jsonDecode(transactionData));

  static List<Transaction> listFromJson(List<dynamic> json) =>
      json.map((e) => Transaction.fromJson(e)).toList();

  excerpt(int i) {
    return (description.length <= i) ?
    description :
    description.substring(0, i - 3) + "...";
  }
}