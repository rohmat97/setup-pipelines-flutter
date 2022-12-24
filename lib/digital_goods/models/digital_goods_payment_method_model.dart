class DigitalGoodsPaymentMethodModel {
  int? id;
  String? name;
  String? type;

  DigitalGoodsPaymentMethodModel({
    this.id,
    this.name,
    this.type,
  });

  DigitalGoodsPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}

class UninitializedDigitalGoodsPaymentMethodModel
    extends DigitalGoodsPaymentMethodModel {}
