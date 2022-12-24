import 'brand.dart';

class Product {
  /*
  "category": "pulsa/data",
  "code": "NELPON 100MNT ALL + 1000MNT",
  "price": 56725,
  "is_active": true,
  "created_at": "2022-08-26T09:36:38.847983",
  "modified_at": "2022-08-26T09:36:48.449086",
  "name": "30HR 100MNT ALL + 1000MNT SSM (ZONA)",
  "id": 263,
  "brand": "TELKOMSEL",
  "payment_type": "PraBayar",
  "created_by": "admin",
  "modified_by": "admin"
  */

  final String category;
  final String code;
  final int price;
  final String name;
  final int id;
  final PaymentType paymentType;

  Product(this.category, this.code, this.price, this.name, this.id, this.paymentType);

  factory Product.fromJson(json){
    String strType = json["payment_type"];
    PaymentType paymentType = strType == "PraBayar"
        ? PaymentType.prePaid
        : PaymentType.postPaid;

    return Product(
        json["category"],
        json["code"],
        json["price"],
        json["name"],
        json["id"],
        paymentType
    );
  }

  static List<Product> listFromJson(List<dynamic> json) => json.map((e) => Product.fromJson(e)).toList();
}