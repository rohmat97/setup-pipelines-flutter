import 'package:flutter/material.dart';
import 'package:kai_wisata/user/invalid_otp_exception.dart';
import 'package:kai_wisata/user/pages/login_page.dart';
import 'package:kai_wisata/user/services/user_services.dart';

class VerificationState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  int countDown = 120;
  bool isResend = true;

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

  void onLoginAccount() {
    Navigator.pushNamed(context!, LoginPage.routeName);
  }

 Future<void> verifyOTP(String id, String text, String text2, String text3, String text4) async{
    String otp = "$text$text2$text3$text4";
    var isValid = await UserService.verifyOTP(id, otp);
    if(isValid){
      Navigator.pushReplacementNamed(
          context!,
          LoginPage.routeName);
    }else {
      throw InvalidOTPException("invalid OTP code, please make sure to type correctly");
    }
  }

  Future<void> resendOTP(String id) async{
    isResend = false;
    await UserService.resendOTP(id);
    notifyListeners();
  }
}
