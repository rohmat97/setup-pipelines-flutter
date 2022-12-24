import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_wisata/pages/tourism_customer_page.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:kai_wisata/wisata/pages/03tourism_checkout_page.dart';

class TourismDestinationState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  int ticketCount = 1;

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

  void onCheckoutButton() {
    Navigator.pushNamed(context!, TourismCheckoutPage.routeName);
  }

  void setTicketCount(int count) {
    ticketCount = count;
    notifyListeners();
  }
}
