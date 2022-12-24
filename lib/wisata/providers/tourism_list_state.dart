import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_wisata/pages/tourism_customer_page.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:kai_wisata/wisata/pages/02tourism_destination_page.dart';

class TourismListState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onWagonSelected() {
    Navigator.pushNamed(context!, TourismDestinationPage.routeName);
  }
}
