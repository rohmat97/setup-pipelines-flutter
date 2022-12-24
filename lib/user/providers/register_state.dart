import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/services/connection_error_exception.dart';
import 'package:kai_wisata/user/models/kai_user.dart';
import 'package:kai_wisata/user/pages/login_page.dart';
import 'package:kai_wisata/user/pages/verification_page.dart';
import 'package:kai_wisata/user/services/user_services.dart';

class RegisterState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  bool isSuccess = false;  

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onLoginAccount() {
    Navigator.pushNamed(context!, LoginPage.routeName);
  }

  void showSnackBar(BuildContext context, String text, Color color, Color dismissColor) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 20,
        right: 20,
      ),
      content: Text(text),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: dismissColor,
        onPressed: () {
          //Do whatever you want
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<dynamic> onRegisterAcc(KAIUser user, bool terms) async {
    var result = await UserService.register(user, terms);
    isSuccess = result["success"] ?? false;

    if (isSuccess) {
      showSnackBar(context!, result["message"], Colors.green, Colors.white);

      Navigator.pushNamed(
        context!,
        LoginPage.routeName,
        arguments: result
      );
    } else {
      return result;
    }
  }

  void onRegisterAccount(KAIUser user, bool terms) async {
    var result = await UserService.register(user, terms);
    isSuccess = result["success"] ?? false;

    if (isSuccess) {
      showSnackBar(context!, result["message"], Colors.green, Colors.white);

      Navigator.pushNamed(
        context!,
        LoginPage.routeName,
        arguments: result
      );
    }

    // ignore: void_checks
    return result;
    // Navigator.pushNamed(
    //     context!,
    //     VerificationPage.routeName,
    //     arguments: result
    // );
    // try {
      
    // } on ConnectionErrorException catch(e){
    //   rethrow;
    // }
  }

  void onBackButton() {
    Navigator.pop(context!);
  }
}
