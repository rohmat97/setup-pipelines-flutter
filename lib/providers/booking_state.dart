import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/pages/02search_result_page.dart';

class BookingState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;


  }

  bool isRoundTrip = false;
  void setRoundTrip(bool value) {
    isRoundTrip = value;
    notifyListeners();
  }

  bool isTicketFlexible = false;
  void setTicketFlexible(bool value) {
    isTicketFlexible = value;
    notifyListeners();
  }

  void onSearchButton() {
    Navigator.pushNamed(context!, SearchResultPage.routeName);
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  int adultTicketCount = 0;

  void setAdultTicketCount(int count) {
    adultTicketCount = count;

    notifyListeners();
  }

  int childTicketCount = 0;

  void setChildTicketCount(int count) {
    childTicketCount = count;

    notifyListeners();
  }

  int infantTicketCount = 0;

  void setInfantTicketCount(int count) {
    infantTicketCount = count;
    notifyListeners();
  }
}
