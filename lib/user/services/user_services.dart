import 'dart:convert';

import 'package:kai_wisata/base_service.dart';
import 'package:kai_wisata/kai_reguler/services/connection_error_exception.dart';
import 'package:kai_wisata/user/invalid_user_password_exception.dart';
import 'package:kai_wisata/user/models/kai_user.dart';

class UserService extends BaseService {
  static Future<dynamic> login(String userName, String password, String accType) async {
    String url = "/api/user/login";
    var params = {
      'login': userName,
      'password': password,
      'type': 'app',
      'acc_type': accType
    };

    var json = await BaseService.postForm(url, params);
    // if (json.containsKey('error')) {
    //   throw InvalidUserPasswordException(json["error"]["message"]);
    // }
    print(json);
    return json;
  }

  static Future<KAIUser> getUser() async{
    String url = "/api/user/user-profile";
    Map<String, dynamic> json = await BaseService.get(url);
    // print(json);
    return KAIUser.fromJson(json["data"]);
  }

  static Future<dynamic> register(KAIUser user, bool terms) async {
    String url = "/api/user/register";
    var data = {
      "password" : user.password,
      "password_confirmation" : user.passwordConfirmation,
      "name" : user.fullName,
      // "username": user.email.replaceAll(RegExp(r"(\@[a-zA-Z0-9]+\.[a-zA-Z]+)"), ""),
      "username": "",
      "email" : user.email,
      "phone" : user.telephone,
      "type": "app",
      "acc_type": user.accType,
      "terms_n_cons_agreement": terms,
    };
    
    var json = await BaseService.post(url, data);
    print(json);
    
    return json;
  }

  static Future<bool> verifyOTP(String id, String otp) async {
    String url = "/user/verifyOtp";
    var data = {
      "userid" : id,
      "code" : otp
    };

    try {
      var json = await BaseService.post(url, data);
      return json["data"] == id;
    } on ConnectionErrorException catch(e){
      rethrow;
    }
  }

  static Future<bool> resendOTP(String id) async {
    String url = "/user/resendEmailOtp/$id";

    try {
      var json = await BaseService.get(url);
      return json["data"];
    } on ConnectionErrorException catch(e){
      rethrow;
    }
  }

  static Future<dynamic> logout() async{
    String url = "/api/user/logout";
    Map<String, dynamic> params = {};
    var json = await BaseService.post(url, params);
    // print(json);
    return json;
  }
}