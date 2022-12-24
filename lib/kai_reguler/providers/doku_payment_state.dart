import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/doku_payment_arguments.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:kai_wisata/pages/ordered_successfully_page.dart';

import 'package:intl/intl.dart';

class DokuPaymentState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  DokuPaymentArguments? args;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey, DokuPaymentArguments args) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void onBackButton() {
    Navigator.pushNamedAndRemoveUntil(context!, HomePage.routeName, (Route<dynamic> route) => false);
  }

  void onNextButton() {
    Navigator.pushNamed(context!, OrderedSuccessfullyPage.routeName);
  }

  get amount =>
      NumberFormat.decimalPattern('id').format(
          args!.schedule.adultDiscount * args!.booking.adults.length
      );
}
