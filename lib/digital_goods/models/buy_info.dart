import 'package:intl/intl.dart';

class BuyInfo {
  final String productCode;
  final String destination;
  final int price;

  BuyInfo(this.productCode, this.destination, this.price);

  String get priceFormatted => NumberFormat.decimalPattern('id').format(price);

  Map<String, dynamic> toJson(){
    return {
      "product_code": productCode,
      "destination": destination,
      "price": price
    };
  }

  factory BuyInfo.fromJson(json) {
    return BuyInfo(
      json["product_code"],
      json["destination"],
      json["price"],
    );
  }
}