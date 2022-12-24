class City {
  /*
  "Name": "Abadi",
      "ID": "161881",
      "CountryID": "ID"
   */

  final String name;
  final String id;
  final String countryId;

  City(this.name, this.id, this.countryId);

  @override
  String toString() {
    return '$id, $name';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is City && other.name == name && other.id == id;
  }

  @override
  int get hashCode => Object.hash(id, name);

  factory City.fromJson(json){
    return City(
      json['Name'],
      json['ID'],
      json['CountryID']
    );
  }

  static List<City> listFromJson(List<dynamic> json) => json.map((e) => City.fromJson(e)).toList();
}