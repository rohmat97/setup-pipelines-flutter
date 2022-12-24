import 'package:kai_wisata/digital_goods/models/buy_info.dart';
import 'package:kai_wisata/digital_goods/models/doku_payment_model.dart';
import 'package:kai_wisata/digital_goods/models/product.dart';
import 'package:kai_wisata/digital_goods/models/digital_goods_transaction.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/digital_goods/models/postpaid_listrik.dart';

import '../../base_service.dart';
import '../models/brand.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class EGoodsServies extends BaseService {
  static Future<List<Brand>> listBrandsByCategory(String category) async {
    // String endPoint = "/api/digital-goods";
    // Map<String, String> params = {
    //   "category": category,
    // };
    // var json = await BaseService.getWithParams(endPoint, params);

    String d =
        '{"data" : [{ "payment_type": "PraBayar", "brand": "Telkomsel" },{ "payment_type": "Prabayar", "brand": "XL" } ] }';
    Map<String, dynamic> json = jsonDecode(d);

    return Brand.listFromJson(json["data"]);
  }

  static Future<List<Product>> listProductByBrand(String brand) async {
    // String endPoint = "/egoods/product/listProductByBrand";
    // Map<String, String> params = {
    //   "brand": brand,
    // };
    // var json = await BaseService.getWithParams(endPoint, params);

    var d =
        '{"data" : [{ "category": "C", "code": "D", "price" : 20000, "name" : "Pulsa 5000", "id" : 100, "payment_type" : "PraBayar" }, { "category": "C", "code": "E2", "price" : 50000, "name" : "Pulsa 10000", "id" : 300, "payment_type" : "PraBayar" } ] }';
    Map<String, dynamic> json = jsonDecode(d);

    return Product.listFromJson(json["data"]);
  }

  static Future<String> buy(BuyInfo info) async {
    String url = "/egoods/buyProduct";
    var json = await BaseService.post(url, info.toJson());
    return json["data"]["url_payment"];
  }

  static Future<List<Transaction>> getTransactionHistories() async {
    // String url = "/egoods/transaction/list";
    // var json = await BaseService.get(url);
    // return Transaction.listFromJson(json["data"]);

    return [];
  }

  static Future<PostpaidListrik> fetchTagihan(String noMeter) async {
    DateTime now = new DateTime.now();
    DateTime reqIdC = new DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);
    int reqId = int.parse(DateFormat('ddMMyyyyHHmmss').format(reqIdC));
    Map<String, dynamic> data = {
      // "request_id": 18122022065639,
      "destination": noMeter,
      "product_name": "PLN PASCABAYAR",
      "use_existing_request_id": 1
    };

    print(jsonEncode(data));
    print(data);

    final response = await BaseService.post('/api/digital-goods/inquiry', data);

    print(response['data']);
    return PostpaidListrik.fromJson(response['data']);
  }

  static Future<DigitalGoodsTransaction> setTransaction(
      PostpaidListrik tagihan, String product_name, String destination) async {
    var json = await BaseService.get('/api/user/user-profile');

    print(json['data']['id']);
    int user_id = json['data']['id'];

    Map<String, dynamic> data = {
      // "request_id": 18122022065639,
      "user_id": user_id,
      "transaction_type": "PREPAID",
      "details": [
        {
          "product_type_id": 1, // PPOB
          "amount": tagihan.amountToCharge,
          "note": "",
          "meta": {
            "request_id": tagihan.requestId,
            "product_type": "PLN PASCA BAYAR",
            "product_name": "PLN PASCABAYAR",
            "destination": destination,
          }
        }
      ]
    };

    print(data);
    final response = await BaseService.post('/api/transaction/create', data);

    print(response['data']);
    return DigitalGoodsTransaction.fromJson(response['data']);
  }

  static Future<String> createPayment(Map<String, dynamic> trxObj) async {
    String url = "/api/payment/generateVA";
    var params = trxObj;
    var json = await BaseService.post(url, params);
    print(json);
    return json["data"]["virtual_account_info"]["how_to_pay_page"];
    // return DokuPaymentModel.fromJson(json["data"]);
  }
}
