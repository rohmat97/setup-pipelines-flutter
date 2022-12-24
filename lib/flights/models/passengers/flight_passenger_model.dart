class FlightPassengerModel {
  int? idx;
  String? idNum;
  String? title;
  String? firtsName;
  String? lastName;
  String? birthDate;
  String? gender;
  String? nation;
  String? birthNation;
  String? idDoc;
  int? parent;
  String? pasporNum;
  String? pasporCountry;
  String? pasporDate;
  String? pasporExpDate;
  String? types;

  FlightPassengerModel({
    this.idx,
    this.idNum,
    this.title,
    this.firtsName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.nation,
    this.birthNation,
    this.idDoc,
    this.parent,
    this.pasporNum,
    this.pasporCountry,
    this.pasporDate,
    this.pasporExpDate,
    this.types,
  });

  FlightPassengerModel.fromJson(Map<String, dynamic> json) {
    idx = json["index"];
    idNum = json["id_number"];
    title = json["title_name"];
    firtsName = json["first_name"];
    lastName = json["last_name"];
    birthDate = json["birth_date"];
    gender = json["gender"];
    nation = json["nationality"];
    birthNation = json["birth_country"];
    idDoc = json["doc_type"];
    parent = 0;
    pasporNum = json["passport_number"];
    pasporCountry = json["passport_issued_country"];
    pasporDate = json["passport_issued_date"];
    pasporExpDate = json["passport_expired_date"];
    types = json["type"];
  }

  Map<String, dynamic> toJson() {
    return {
      'index': idx,
      'id_number': idNum,
      'title_name': title,
      'first_name': firtsName,
      'last_name': lastName,
      'birth_date': birthDate,
      'gender': gender,
      'nationality': nation,
      'birth_country': birthNation,
      'doc_type': idDoc,
      'parent': types == "Adult" ? "" : "0",
      'passport_number': pasporNum,
      'passport_issued_country': pasporCountry,
      'passport_issued_date': pasporDate,
      'passport_expired_date': pasporExpDate,
      'type': types,
    };
  }
}

class UninitializedFlightPassengerModel extends FlightPassengerModel {}
