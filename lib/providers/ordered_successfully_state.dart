import 'package:flutter/material.dart';
import 'package:kai_wisata/pages/order_details_page.dart';

class OrderedSuccessfullyState with ChangeNotifier {
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

  void onNextButton() {
    Navigator.pushNamed(context!, OrderDetailsPage.routeName);
  }
}
