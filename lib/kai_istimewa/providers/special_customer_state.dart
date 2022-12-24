import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_istimewa/pages/02special_detail_page.dart';

import '../arguments/special_arguments.dart';
import '../models/special_booking.dart';

class SpecialCustomerState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  SpecialArguments? args;

  String name = "";
  String email = "";
  String phone = "";
  String company = "";
  String address = "";

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
      SpecialArguments args
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
    name = args.info.name;
    email = args.info.email;
    phone = args.info.phone;
    company = args.info.company;
    address = args.info.address;
  }

  void setName(String name){
    this.name = name;
    notifyListeners();
  }

  void setEmail(String name){
    email = name;
    notifyListeners();
  }

  void setPhone(String name){
    phone = name;
    notifyListeners();
  }

  void setCompany(String name){
    company = name;
    notifyListeners();
  }

  void setAddress(String name){
    address = name;
    notifyListeners();
  }

  void onBackButton(String name, String email, String phone, String company, String address) {
    var newInfo = SpecialBookingInfo(
        args!.info.org,
        args!.info.des,
        args!.info.departure,
        args!.info.layanan,
        args!.info.note,
        args!.info.total,
        args!.info.penumpang,
        args!.info.title,
        name,
        email,
        phone,
        company,
        address,
        args!.info.idCardType,
        args!.info.idCardNumber
    );

    Navigator.pushReplacementNamed(
        context!, SpecialDetailPage.routeName,
        arguments: SpecialArguments(newInfo)
    );
  }
}
