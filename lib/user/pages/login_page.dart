import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/commons/validator.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/user/invalid_user_password_exception.dart';
import 'package:kai_wisata/user/providers/login_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_login_button.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../kai_reguler/services/connection_error_exception.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-pages';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  LoginState state = LoginState();
  final _formKey = GlobalKey<FormState>();

  late bool isEmailValid = true;
  late bool rememberMe = false;
  late bool visibility = true;

  final List<bool> _selection = [true, false];

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String accType = 'b2c';

  void _onRememberMeChanged(bool? newValue) {
    return setState(
      () {
        rememberMe = newValue!;

        if (rememberMe) {
        } else {}
      },
    );
  }

  void showError(String message){
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          Container(
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width *
                        0.2,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.red
                        ),
                      ),
                    ),
                    KaiButton(
                      text: 'Try again',
                      onClick: () => Navigator.pop(context),
                      buttonColor: KaiColor.blue,
                      textColor: KaiColor.white,
                      sideColor: KaiColor.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<LoginState>(context);
    state.initState(context, scaffoldKey);
    return Scaffold(
      backgroundColor: KaiColor.white,
      appBar: AppBar(
        leading: const Text(''),
        title: Image.asset(
          'assets/kawisata-logo-nobg.png',
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  left: 18.0,
                  right: 18.0,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Selamat Datang \ndi GOwisata',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                  margin: const EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: ToggleButtons(
                      renderBorder: true,
                      borderWidth: 1.5,
                      borderRadius: BorderRadius.circular(10),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Personal',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Business',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                      isSelected: _selection,
                      onPressed: (int newIndex) {
                        setState(() {
                          // looping through the list of booleans values
                          for (int index = 0; index < _selection.length; index++) {
                            // checking for the index value
                            if (index == newIndex) {
                              // one button is always set to true
                              _selection[index] = true;
                              accType = 'b2c';
                            } else {
                              // other two will be set to false and not selected
                              _selection[index] = false;
                              accType = 'b2b';
                            }
                          }
                          
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 18.0,
                  left: 18.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email atau No. Hp',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: KaiTextField(
                  widget: const Text(''),
                  obscure: false,
                  textController: emailController,
                  hint: 'Masukkan Email atau No. Hp',
                  color: KaiColor.homeBackground,
                  validator: (value) => TextFieldValidator.phoneOrEmail(value),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 18.0,
                  left: 18.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: KaiTextField(
                  widget: InkWell(
                    child: visibility == true
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                    onTap: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                  ),
                  obscure: visibility,
                  textController: passController,
                  hint: 'Masukkan Password',
                  color: KaiColor.homeBackground,
                  validator: (value) => TextFieldValidator.passwordIsEmpty(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: _onRememberMeChanged,
                        ),
                        const Text(
                          'Ingat Saya',
                          style: KaiTextStyle.titleSmallThin,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => state.onForgotPassword(),
                      child: Text(
                        'Lupa Password',
                        style: KaiTextStyle.titleSmallBold.apply(
                          color: KaiColor.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              KaiButton(
                padding: const EdgeInsets.all(18.0),
                text: 'Masuk',
                onClick: () async {
                  if (_formKey.currentState!.validate()) {
                    // Navigator.pushNamed(context, "/home-pages");
                    await state.onLoginAccount(emailController.text, passController.text, accType);
                    // runZonedGuarded(() async {
                    //   await state.onLoginAccount(emailController.text, passController.text, accType);
                    // }, (error, stack) {
                    //   if(error is InvalidUserPasswordException) {
                    //     showError(error.message);
                    //   }else if (error is ConnectionErrorException) {
                    //     showError(error.cause);
                    //   }
                    //   else {
                    //     showError(error.toString());
                    //   }
                    // });
                  }
                },
                buttonColor: KaiColor.blue,
                textColor: Colors.white,
                sideColor: KaiColor.blue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: () => state.onRegisterAccount(),
                    child: const Text(
                      'Daftar disini',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: KaiColor.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
