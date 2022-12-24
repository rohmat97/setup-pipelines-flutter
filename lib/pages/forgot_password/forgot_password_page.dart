import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/forgot_password/forgot_password_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgot-password-pages';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  ForgotPasswordState state = ForgotPasswordState();

  bool isEmailValid = true;
  bool visibility = false;

  TextEditingController emailController = TextEditingController();

  Widget checkEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KaiColor.greenBg,
          border: Border.all(
            color: KaiColor.greenText,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            right: 18.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/svg/green_check.svg',
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 12.0,
                      left: 14.0,
                      right: 14.0,
                    ),
                    child: Text(
                      'Kami telah mengirim kode verifikasi',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: KaiColor.greenText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0,
                      left: 14.0,
                      right: 14.0,
                    ),
                    child: Text(
                      'Silakan cek email anda',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: KaiColor.greenText,
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

  @override
  Widget build(BuildContext context) {
    state = Provider.of<ForgotPasswordState>(context);
    state.initState(context, scaffoldKey);
    return Scaffold(
      backgroundColor: KaiColor.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: KaiColor.black,
            size: 25.0,
          ),
          onPressed: () => state.onBackButton(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Image.asset(
          'assets/kawisata-logo-nobg.png',
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
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
                  'Lupa Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 18.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Text(
                'Masukkan Email yang sudah pernah terdaftar',
                textAlign: TextAlign.center,
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
                  'Email',
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
                hint: 'contoh@email.com',
                color: KaiColor.homeBackground,
              ),
            ),
            KaiButton(
              padding: const EdgeInsets.all(18.0),
              text: 'Kirim',
              onClick: () {
                setState(() {
                  visibility = !visibility;
                });
                Timer(
                  const Duration(seconds: 3),
                  () => state.onButtonPressed(),
                );
              },
              buttonColor: KaiColor.blue,
              textColor: Colors.white,
              sideColor: KaiColor.blue,
            ),
            visibility == true ? checkEmail() : Container(),
          ],
        ),
      ),
    );
  }
}
