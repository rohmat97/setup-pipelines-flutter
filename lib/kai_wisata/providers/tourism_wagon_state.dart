import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_wisata/pages/04tourism_detail_page.dart';
import 'package:kai_wisata/kai_wisata/services/wisata_services.dart';

import '../arguments/tourism_customer_arguments.dart';
import '../arguments/tourism_wagon_arguments.dart';
import '../models/tourism_customer.dart';
import '../models/tourism_tipe.dart';
import '../models/tourism_book_info.dart';

class TourismWagonState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  TourismWagonArguments? args;

  List<TourismTipe> wagons = [];
  bool isLoaded = false;

  void initState(BuildContext ctx, GlobalKey<ScaffoldState> scaffoldKey,
      TourismWagonArguments args) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void listWagon() async {
    if (!isLoaded) {
      wagons = await WisataService.listTipes();
      isLoaded = true;
      notifyListeners();
    }
  }

  void onWagonSelected(TourismTipe e) {
    Navigator.pushNamed(context!, TourismDetailPage.routeName,
        arguments: TourismCustomerArguments(args!.searchArguments,
            args!.schedule, e, TourismCustomer.empty(e)));
  }
}
