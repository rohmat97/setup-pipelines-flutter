import 'package:flutter/material.dart';
import 'package:kai_wisata/user/pages/login_page.dart';

class PasswordChangedState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onButtonPressed() {
    Navigator.pushNamedAndRemoveUntil(
      context!,
      LoginPage.routeName,
      (Route<dynamic> route) => false,
    );
  }
}
