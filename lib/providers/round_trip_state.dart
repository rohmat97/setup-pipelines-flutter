import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/pages/03input_passenger_page.dart';

class RoundTripState with ChangeNotifier {
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

  void onTicketSelected() {
    Navigator.pushNamed(context!, InputPassengerPage.routeName);
  }
}
