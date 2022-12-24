import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kai_wisata/flights/models/contacts/flight_contact_model.dart';

class ContactCache {
  Box? box;
  ContactCache._privateConstructor();

  Future<void> init() async {
    box = await Hive.openBox<void>((ContactCache).toString());
  }

  static final ContactCache _instance = ContactCache._privateConstructor();
  static ContactCache get instance => _instance;

  void saveContacts(FlightContactModel contact){
    box?.put("contact", jsonEncode(contact.toJson()));
  }

  FlightContactModel? getContacts(){
    var json = box?.get("contact", defaultValue: "");
    
    return json == "" ? null: FlightContactModel.fromJson(jsonDecode(json));
  }
}