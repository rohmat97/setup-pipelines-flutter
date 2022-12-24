import 'dart:convert';

class KAIUser {
  /*
  "fullname": "zefri yazid",
      "username": "zefri",
      "email": "zefri@gmail.com",
      "address": "",
      "postal_code": "",
      "id_card_number": "sdfgsdfgdsf",
      "is_enabled": true,
      "created_at": "2022-08-06T11:44:42.225907",
      "modified_at": "2022-08-29T03:43:03.218150",
      "id": "11f96bed-819c-4183-a8d6-592e3a4bbc9f",
      "userpass": "54118a11f3489639f9b987f2f14e540a",
      "telephone": "123456789",
      "city": "",
      "id_card_type": "NIK",
      "profile_pic": null,
      "is_verified": false,
      "created_by": "zefri",
      "modified_by": "datu"
   */

  final String id;
  final String userName;
  final String fullName;
  final String email;
  final String telephone;
  final String password;
  final String passwordConfirmation;
  final String message;
  final String accType;

  KAIUser(this.id, this.userName, this.fullName, this.email, this.telephone, this.password, this.passwordConfirmation, this.message, this.accType);

  factory KAIUser.fromJson(json){
    return KAIUser(
        json["id"].toString(),
        json["username"],
        json["name"],
        json["email"],
        json["phone"],
        "",
        "",
        "",
        json["acc_type"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "username" : userName,
      "password" : password,
      "password_confirmation" : password,
      "name" : fullName,
      "email" : email,
      "phone" : telephone,
      "acc_type": accType
    };
  }
}