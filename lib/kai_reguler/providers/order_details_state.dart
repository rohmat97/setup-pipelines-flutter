import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/selected_payment_arguments.dart';

class OrderDetailsState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onNextButton() {
    Navigator.pop(context!);
  }
}
