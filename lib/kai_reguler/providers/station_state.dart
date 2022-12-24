import 'package:flutter/material.dart';
import 'package:kai_wisata/pages/round_trip_page.dart';

class StationState with ChangeNotifier {
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
    Navigator.pushNamed(context!, RoundTripPage.routeName);
  }
}
