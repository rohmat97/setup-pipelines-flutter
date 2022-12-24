class Station {

  final String code;
  final String name;

  factory Station.fromJson(Map<String, dynamic> json) => Station(json["code"], json["name"]);

  Station(this.code, this.name);

  @override
  String toString() {
    return "$name ($code)";
  }

  String getCutName(int max){
    return name.length <= max ? toString() :"${name.substring(0, max-1)} ($code)";
  }
}