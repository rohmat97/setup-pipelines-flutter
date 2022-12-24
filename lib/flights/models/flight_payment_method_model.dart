class FlightPaymentMethodModel {
  int? id;
  String? name;
  String? type;
  
  FlightPaymentMethodModel({
    this.id,
    this.name,
    this.type,
  });

  FlightPaymentMethodModel.fromJson(Map<String, dynamic> json) {
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

class UninitializedFlightPaymentMethodModel extends FlightPaymentMethodModel {}