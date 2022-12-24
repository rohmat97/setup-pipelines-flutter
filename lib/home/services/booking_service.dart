import 'package:kai_wisata/base_service.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/home/models/histories/history_booking_model.dart';
import 'package:kai_wisata/home/models/history_payment.dart';

import '../../kai_reguler/models/rail_booking_info.dart';

class BookingServices extends BaseService {
  // static Future<List<Transaction>> getKAITransactionHistories() async {
  //   String url = "/kereta/transaction/list";
  //   var json = await BaseService.get(url);
  //   return Transaction.listFromJson(json["data"]);
  // }
  static Future<dynamic> getKAITransactionHistories(
      int page,
      int perPage,
      String orderBy,
      String sortBy,
      String trxStatus,
      String payStatus,
      String productType) async {
    Map<String, dynamic> params = {
      "page": '$page',
      "per_page": '$perPage',
      "order": orderBy,
      "sort_by": sortBy,
      // "transaction_status": trxStatus,
      // "payment_status": payStatus,
      "product_type": productType,
    };
    print(params);

    String url = "/api/transaction/list";

    var json = await BaseService.getWithParams(url, params);
    print(json);

    if (json["status"] == true) {
      List<HistoryBookingModel> bookings = [];

      for (var bk in json["data"]) {
        bookings.add(HistoryBookingModel.fromJson(bk));
      }

      return bookings;
    } else {
      throw Exception(json);
    }
  }

  static Future<Transaction> getKAITransactionInfo(String bookCode) async {
    String url = "/kereta/transaction/$bookCode";

    var json = await BaseService.get(url);
    return Transaction.fromJson(json["data"]);
  }

  static Future<List<Transaction>> getEGoodsTransactionHistories() async {
    String url = "/egoods/transaction/list";
    var json = await BaseService.get(url);
    return Transaction.listFromJson(json["data"]);
  }

  static Future<List<Transaction>> getTourismTransactionHistories() async {
    String url = "/kawisata/transaction/list";
    var json = await BaseService.get(url);
    return Transaction.listFromJson(json["data"])
        .where((element) => element.isValid)
        .toList();
  }

  static Future<List<Transaction>> getSpecialTransactionHistories() async {
    String url = "/kaistimewa/transaction/list";
    var json = await BaseService.get(url);
    return Transaction.listFromJson(json["data"])
        .where((element) => element.isValid)
        .toList();
  }

  static Future<dynamic> getFlightTransactionHistories(
      int page,
      int perPage,
      String orderBy,
      String sortBy,
      String trxStatus,
      String payStatus,
      String productType) async {
    Map<String, dynamic> params = {
      "page": '$page',
      "per_page": '$perPage',
      "order": orderBy,
      "sort_by": sortBy,
      // "transaction_status": trxStatus,
      // "payment_status": payStatus,
      "product_type": productType,
    };

    String url = "/api/transaction/list";
    var json = await BaseService.getWithParams(url, params);
    print(json);

    if (json["status"] == true) {
      List<HistoryBookingModel> bookings = [];

      for (var bk in json["data"]) {
        bookings.add(HistoryBookingModel.fromJson(bk));
      }

      return bookings;
    } else {
      throw Exception(json);
    }
  }

  static Future<dynamic> printETicket(String bookingCode) async {
    Map<String, dynamic> data = {"booking_code": bookingCode};

    var json = await BaseService.postNoEncode('/api/train/e_ticket', data);

    return json;
  }
}
