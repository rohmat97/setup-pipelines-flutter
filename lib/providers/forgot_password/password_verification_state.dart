import 'package:flutter/material.dart';
import 'package:kai_wisata/pages/forgot_password/new_password_page.dart';

class PasswordVerificationState with ChangeNotifier {
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

  void onButtonPressed() {
    Navigator.pushNamed(context!, NewPasswordPage.routeName);
  }
}
