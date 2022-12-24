import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/pages/forgot_password/forgot_password_page.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:kai_wisata/user/pages/register_page.dart';
import 'package:kai_wisata/user/models/auth_cache.dart';
import 'package:kai_wisata/user/models/kai_user.dart';
import 'package:kai_wisata/user/services/user_services.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';

class LoginState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  bool isSuccess = false;

  List<dynamic> emailErr = [];
  String passErr = '';

  String emailErrStr = '';
  String passErrStr = '';

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onRegisterAccount() {
    Navigator.pushNamed(context!, RegisterPage.routeName);
  }

  Future<dynamic> onLoginAccount(String userName, String password, String accType) async {
    var token = await UserService.login(userName, password, accType);
    isSuccess = token["success"] ?? false;

    if (isSuccess) {
      AuthCache.instance.save(token["data"]["access_token"]);
      Map<String, dynamic> payload = Jwt.parseJwt(token["data"]["access_token"]);
      // var userId = payload["userid"];
      KAIUser user = await UserService.getUser();
      AuthCache.instance.saveUser(user);

      Navigator.pushNamedAndRemoveUntil(context!, HomePage.routeName, (Route<dynamic> route) => false);
    } else {
      emailErr = token["email"] ?? [];
      passErr = token["message"] ?? '';

      if (emailErr.isNotEmpty) {
        emailErrStr = emailErr[0] != '' ? emailErr[0] : '';
        passErrStr = '';
      }

      if (passErr == 'Unauthorized') {
        passErrStr = 'Wrong password!';
        emailErrStr = '';
      }

      // print(token);
      await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        isScrollControlled: true,
        context: context!,
        builder: (context) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
            color: KaiColor.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: SvgPicture.asset(
                  'assets/svg/bar_line.svg',
                  width: MediaQuery.of(context).size.width *
                      0.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    emailErrStr != '' ? Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                      child: Text(
                        'Email: ' + emailErrStr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ) : const Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    passErrStr != '' ? Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                      child: Text(
                        'Password: ' + passErrStr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ) : const Text(
                        '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                    ),
                  ],
                ),
              ),
              KaiCustomButton(
                text: 'Tutup',
                onClick: () async {
                  Navigator.pop(context);
                },
                buttonColor: KaiColor.blue,
                textColor: KaiColor.white,
                sideColor: KaiColor.blue,
                width: MediaQuery.of(context).size.width,
                height: 40,
              ),
            ],
          ),
        ),
      );
    }
  }

  // void onLoginAccount(String userName, String password, String accType) async {
  //   String token = await UserService.login(userName, password, accType);
  //   AuthCache.instance.save(token);
  //   Map<String, dynamic> payload = Jwt.parseJwt(token);
  //   // var userId = payload["userid"];
  //   KAIUser user = await UserService.getUser();
  //   AuthCache.instance.saveUser(user);

  //   Navigator.pushNamed(context!, HomePage.routeName);
  // }

  void onForgotPassword() {
    Navigator.pushNamed(context!, ForgotPasswordPage.routeName);
  }
}
