import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_istimewa/models/special_booking.dart';
import 'package:kai_wisata/kai_istimewa/models/special_description.dart';
import 'package:kai_wisata/kai_istimewa/pages/special_customer_page.dart';
import 'package:kai_wisata/kai_istimewa/services/special_services.dart';
import 'package:kai_wisata/pages/home/home_page.dart';

import '../arguments/special_arguments.dart';

class SpecialDetailState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  String note = "";
  int capacity = 0;
  SpecialDescription? description;
  SpecialArguments? args;
  bool isLoaded = false;
  bool isAgree = false;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
      SpecialArguments args
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void setCapacity(int cap){
    capacity = cap;
    notifyListeners();
  }

  void setNote(int cap){
    capacity = cap;
    notifyListeners();
  }

  void setAgree(bool agree, int penumpang, String note){
    isAgree = agree;
    capacity = penumpang;
    note = note;
    notifyListeners();
  }

  void getDetail() async {
    if(!isLoaded) {
      description = await SpecialServices.getDescription();
      isLoaded = true;
      notifyListeners();
    }
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onCustomerSelected(int penumpang, String note) {
    var newInfo = SpecialBookingInfo(
        args!.info.org,
        args!.info.des,
        args!.info.departure,
        args!.info.layanan,
        note,
        args!.info.total,
        penumpang,
        args!.info.title,
        args!.info.name,
        args!.info.email,
        args!.info.phone,
        args!.info.company,
        args!.info.address,
        args!.info.idCardType,
        args!.info.idCardNumber
    );

    Navigator.pushNamed(
        context!,
        SpecialCustomerPage.routeName,
        arguments: SpecialArguments(newInfo)
    );
  }

  Future<void> onFinishButton(int penumpang, String note) async {
    var newInfo = SpecialBookingInfo(
        args!.info.org,
        args!.info.des,
        args!.info.departure,
        args!.info.layanan,
        note,
        args!.info.total,
        penumpang,
        args!.info.title,
        args!.info.name,
        args!.info.email,
        args!.info.phone,
        args!.info.company,
        args!.info.address,
        args!.info.idCardType,
        args!.info.idCardNumber
    );

    await SpecialServices.book(newInfo);
    Navigator.pushNamed(context!, HomePage.routeName);
  }
}
