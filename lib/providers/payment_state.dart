import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/pages/05selected_payment_page.dart';

class PaymentState with ChangeNotifier {
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
    Navigator.pushNamed(context!, SelectedPaymentPage.routeName);
  }
}
