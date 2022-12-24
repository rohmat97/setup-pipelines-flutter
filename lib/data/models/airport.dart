class Airport {

  final String id;
  final String airportName;
  final String airportCode;
  final String airportCity;
  final String airportCountry;

  Airport(
    this.id,
    this.airportName,
    this.airportCode,
    this.airportCity,
    this.airportCountry,
  );

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
    json['id'].toString(),
    json['name'],
    json['code'],
    json['city'],
    json['country']
  );

  factory Airport.fromLocalJson(Map<String, dynamic> json) => Airport(
    json['id'].toString(),
    json['name'],
    json['code'],
    json['city'],
    json['country']
  );

  Map<String, dynamic> toJson() {
    return {
      'id_airport': id,
      'airport_name': airportName,
      'airport_code': airportCode,
      'airport_city': airportCity,
      'airport_country': airportCountry,
    };
  }

  @override
  String toString() {
    return "$airportName ($airportCode)";
  }

  String getCutName(int max){
    return airportName.length <= max ? toString() :"${airportName.substring(0, max-1)} ($airportCode)";
  }
}