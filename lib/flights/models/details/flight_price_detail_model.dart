class FlightPriceDetailModel {
  String? paxType;
  double? baseFare;
  double? tax;
  double? totalFare;
  String? bagInfo;
  String? priceInfo;
  
  FlightPriceDetailModel({
    this.paxType,
    this.baseFare,
    this.tax,
    this.totalFare,
    this.bagInfo,
    this.priceInfo,
  });

  FlightPriceDetailModel.fromJson(Map<String, dynamic> json) {
    paxType = json["paxType"];
    baseFare = double.parse( json["baseFare"].toString());
    tax = double.parse(json["tax"].toString());
    totalFare = double.parse(json["totalFare"].toString());
    bagInfo = json["bagInfo"] == null ? "" : json["bagInfo"];
    priceInfo = json["priceInfo"] == null ? "" : json["priceInfo"];
  }

  Map<String, dynamic> toJson() {
    return {
      'paxType': paxType,
      'baseFare': baseFare,
      'tax': tax,
      'totalFare': totalFare,
      'bagInfo': bagInfo,
      'priceInfo': priceInfo,
    };
  }
}

class UninitializedFlightPriceDetailModel extends FlightPriceDetailModel {}