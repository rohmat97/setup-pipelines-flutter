import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/pages/onboarding/onboarding_screen.dart';
import 'package:kai_wisata/user/models/kai_user.dart';
import 'package:kai_wisata/user/services/user_services.dart';

class SplashState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onFinishFetching() {
    Navigator.pushNamed(context!, OnBoardingPage.routeName);
  }

  Future<bool> getUser() async {
    try {
      KAIUser user = await UserService.getUser();

      if (user.id.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
