class AirportsModel {
  String? id;
  String? airportName;
  String? airportCode;
  String? airportCity;
  String? airportCountry;

  AirportsModel({
    this.id,
    this.airportName,
    this.airportCode,
    this.airportCity,
    this.airportCountry,
  });

  AirportsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    airportName = json['name'];
    airportCode = json['code'];
    airportCity = json['city'];
    airportCountry = json['country'];
  }

  AirportsModel.fromLocalJson(Map<String, dynamic> json) {
    id = json['id_airport'].toString();
    airportName = json['airport_name'];
    airportCode = json['airport_code'];
    airportCity = json['airport_city'];
    airportCountry = json['airport_country'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_airport': id,
      'airport_name': airportName,
      'airport_code': airportCode,
      'airport_city': airportCity,
      'airport_country': airportCountry,
    };
  }

  static List<AirportsModel> listFromJson(List<dynamic> json) => json.map((e) => AirportsModel.fromJson(e)).toList();
}
