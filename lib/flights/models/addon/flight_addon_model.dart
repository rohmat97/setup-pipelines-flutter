class FlightAddOnModel {
  String? origin;
  String? destination;
  bool? isEnableNoBaggage;
  bool? isBaggageBundling;
  
  FlightAddOnModel({
    this.origin,
    this.destination,
    this.isEnableNoBaggage,
    this.isBaggageBundling,
  });

  FlightAddOnModel.fromJson(Map<String, dynamic> json) {
    origin = json['origin'];
    destination = json['destination'];
    isEnableNoBaggage = json['isEnableNoBaggage'];
    isBaggageBundling = json['isBaggageBundling'];
  }

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'destination': destination,
      'isEnableNoBaggage': isEnableNoBaggage,
      'isBaggageBundling': isBaggageBundling,
    };
  }
}

class UninitializedFlightAddOnModel extends FlightAddOnModel {}