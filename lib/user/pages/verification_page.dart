import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/user/providers/verification_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:provider/provider.dart';

import '../../kai_reguler/services/connection_error_exception.dart';
import '../invalid_otp_exception.dart';
import '../invalid_user_password_exception.dart';
import 'login_page.dart';

class VerificationPage extends StatefulWidget {
  static const routeName = '/verification-pages';

  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  VerificationState state = VerificationState();

  bool isEmailValid = true;

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();

  void showError(String message) {
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
                      padding: EdgeInsets.all(18.0),
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
    final userId =
    ModalRoute
        .of(context)!
        .settings
        .arguments as String;

    state = Provider.of<VerificationState>(context);
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
          tooltip: MaterialLocalizations
              .of(context)
              .backButtonTooltip,
        ),
        title: Image.asset(
          'assets/kawisata-logo-nobg.png',
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
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
                bottom: 20.0,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Kode Verifikasi',
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
                left: 30.0,
                right: 30.0,
                bottom: 20.0,
              ),
              child: Text(
                'Masukkan kode verifikasi sesuai email yang telah kami kirim.',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
                right: 50.0,
                bottom: 16.0,
              ),
              child: Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 56.0,
                      width: 56.0,
                      child: TextField(
                        controller: otp1,
                        style: const TextStyle(
                          color: KaiColor.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: otp1.text.isEmpty
                                  ? KaiColor.grey
                                  : KaiColor.blue,
                              width: otp1.value.text.isEmpty ? 2.0 : 3.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: otp1.text.isEmpty
                                  ? KaiColor.grey
                                  : KaiColor.blue,
                              width: otp1.value.text.isEmpty ? 2.0 : 3.0,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 56.0,
                      width: 56.0,
                      child: TextField(
                        controller: otp2,
                        style: const TextStyle(
                          color: KaiColor.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            // FocusScope.of(context).nextFocus();

                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: otp2.text.isEmpty
                                  ? KaiColor.grey
                                  : KaiColor.blue,
                              width: otp2.value.text.isEmpty ? 2.0 : 3.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: otp2.text.isEmpty
                                  ? KaiColor.grey
                                  : KaiColor.blue,
                              width: otp2.value.text.isEmpty ? 2.0 : 3.0,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 56.0,
                      width: 56.0,
                      child: TextField(
                        controller: otp3,
                        style: const TextStyle(
                          color: KaiColor.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: otp3.text.isEmpty
                                  ? KaiColor.grey
                                  : KaiColor.blue,
                              width: otp3.value.text.isEmpty ? 2.0 : 3.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: otp3.text.isEmpty
                                  ? KaiColor.grey
                                  : KaiColor.blue,
                              width: otp3.value.text.isEmpty ? 2.0 : 3.0,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 56.0,
                      width: 56.0,
                      child: TextField(
                        controller: otp4,
                        style: const TextStyle(
                          color: KaiColor.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {}
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: otp4.text.isEmpty
                                  ? KaiColor.grey
                                  : KaiColor.blue,
                              width: otp4.value.text.isEmpty ? 2.0 : 3.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: otp4.text.isEmpty
                                  ? KaiColor.grey
                                  : KaiColor.blue,
                              width: otp4.value.text.isEmpty ? 2.0 : 3.0,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            KaiButton(
              padding: const EdgeInsets.all(18.0),
              text: 'Konfirmasi',
              onClick: () async {
                runZonedGuarded(() {
                  state.verifyOTP(
                    userId,
                    otp1.text,
                    otp2.text,
                    otp3.text,
                    otp4.text,
                  );
                }, (error, stack) {
                  if (error is InvalidOTPException) {
                    showError(error.message);
                  } else if (error is ConnectionErrorException) {
                    showError(error.cause);
                  }
                  else {
                    showError(error.toString());
                  }
                });
              },
              buttonColor: KaiColor.blue,
              textColor: KaiColor.white,
              sideColor: KaiColor.blue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum menerima? '),
                GestureDetector(
                  onTap: () {
                    if (state.isResend) {
                      runZonedGuarded(() {
                        state.resendOTP(userId);
                      }, (error, stack) {
                        if (error is InvalidOTPException) {
                          showError(error.message);
                        } else if (error is ConnectionErrorException) {
                          showError(error.cause);
                        }
                        else {
                          showError(error.toString());
                        }
                      });
                    }
                  },
                  child: Text(
                    'Kirim Ulang Kode',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: state.isResend ? KaiColor.blue : KaiColor.grey,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
