import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kai_wisata/user/models/kai_user.dart';

class AuthCache {
  Box? box;
  AuthCache._privateConstructor();

  Future<void> init() async {
    box = await Hive.openBox<void>((AuthCache).toString());
  }

  static final AuthCache _instance = AuthCache._privateConstructor();
  static AuthCache get instance => _instance;

  void save(String token) {
    box?.put("TOKEN", token);
  }

  String get(){
    return box?.get("TOKEN", defaultValue: "");
  }

  String getToken(){
    return box?.get("TOKEN", defaultValue: "");
  }

  void saveUser(KAIUser user){
    box?.put("USER", jsonEncode(user.toJson()));
  }

  KAIUser? getUser(){
    var json = box?.get("USER", defaultValue: "");
    return json == "" ? null: KAIUser.fromJson(jsonDecode(json));
  }
}