import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/services/connection_error_exception.dart';
import 'package:kai_wisata/user/providers/register_state.dart';
import 'package:kai_wisata/user/models/kai_user.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:kai_wisata/widgets/kai_text_group_field.dart';
import 'package:provider/provider.dart';

import '../../commons/validator.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register-pages';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  RegisterState state = RegisterState();

  bool isEmailValid = true;
  late bool termsConditions = true;
  late bool visibility1 = true;
  late bool visibility2 = true;

  final List<bool> _selection = [true, false];

  bool isAggree = false;

  String accType = "b2c";

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  List<dynamic> userNameErr = [];
  List<dynamic> emailErr = [];
  List<dynamic> nameErr = [];
  List<dynamic> phoneErr = [];
  List<dynamic> passErr = [];
  List<dynamic> termsNConsAgreementErr = [];

  String userNameErrStr = '';
  String emailErrStr = '';
  String nameErrStr = '';
  String phoneErrStr = '';
  String passErrStr = '';
  String termsNConsAgreementErrStr = '';

  String trems = '';

  void _onTermsConditions(bool? newValue) {
    return setState(
      () {
        termsConditions = newValue!;

        if (termsConditions) {
        } else {}
      },
    );
  }

  Widget errTerms() {
    return Text(
      'Anda harus menyetujui Syarat dan Ketentuan',
      style: KaiTextStyle.titleSmallThin.apply(
        decoration: TextDecoration.underline,
        color: KaiColor.red,
      ),
    );
  }

  Widget noErrTerms() {
    return const Text('');
  }

  void showError(String message) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
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
                width: MediaQuery.of(context).size.width * 0.2,
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
                        color: Colors.red),
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
    state = Provider.of<RegisterState>(context);
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
                  'Buat Akun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 18.0,
              ),
              child: ToggleButtons(
                renderBorder: true,
                borderWidth: 1.5,
                borderRadius: BorderRadius.circular(10),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Personal',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Business',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
            const Padding(
              padding: EdgeInsets.only(
                top: 18.0,
                left: 18.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nama Lengkap',
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
                textController: nameController,
                validator: (value) => TextFieldValidator.isNotEmptyName(value!),
                hint: 'Masukkan nama lengkap',
                color: KaiColor.homeBackground,
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(
            //     top: 18.0,
            //     left: 18.0,
            //   ),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       'Nama User',
            //       style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 4.0),
            //   child: KaiTextField(
            //     widget: const Text(''),
            //     obscure: false,
            //     textController: userNameController,
            //     validator: (value) => TextFieldValidator.isNotEmpty(value),
            //     hint: 'Masukkan nama user',
            //     color: KaiColor.homeBackground,
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.only(
                top: 18.0,
                left: 18.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nomor Telepon',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: KaiTextGroupField(
                obscure: false,
                textController: phoneController,
                validator: (value) => TextFieldValidator.validatePhone(value),
                hint: 'Masukkan nomor telepon',
                color: KaiColor.homeBackground,
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
                validator: (value) => TextFieldValidator.validateEmail(value),
                hint: 'contoh@email.com',
                color: KaiColor.homeBackground,
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
                  child: visibility1 == true
                      ? const Icon(
                          Icons.visibility,
                        )
                      : const Icon(
                          Icons.visibility_off,
                        ),
                  onTap: () {
                    setState(() {
                      visibility1 = !visibility1;
                    });
                  },
                ),
                obscure: visibility1,
                validator: (value) => TextFieldValidator.passwordIsEmpty(value),
                textController: passController,
                hint: 'Masukkan password',
                color: KaiColor.homeBackground,
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
                  'Konfirmasi Password',
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
                  child: visibility2 == true
                      ? const Icon(
                          Icons.visibility,
                        )
                      : const Icon(
                          Icons.visibility_off,
                        ),
                  onTap: () {
                    setState(() {
                      visibility2 = !visibility2;
                    });
                  },
                ),
                obscure: visibility2,
                textController: confirmController,
                validator: (value) {
                  if (value != passController.text) {
                    return "Password tidak sama!";
                  } else if (value == null || value.isEmpty) {
                    return "Konfirmasi password tidak boleh kosong!";
                  }
                  return null;
                },
                hint: 'Ulangi password',
                color: KaiColor.homeBackground,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18, left: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: termsConditions,
                            onChanged: _onTermsConditions,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Syarat dan Ketentuan',
                              style: KaiTextStyle.titleSmallThin.apply(
                                decoration: TextDecoration.underline,
                                color: KaiColor.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isAggree,
                    child: Text(
                      'Anda harus menyetujui Syarat dan Ketentuan',
                      style: KaiTextStyle.titleSmallThin.apply(
                        // decoration: TextDecoration.underline,
                        color: KaiColor.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            KaiButton(
              padding: const EdgeInsets.all(18.0),
              text: 'Daftar',
              onClick: () async {
                if (termsConditions == false) {
                  setState(() {
                    trems = 'Anda harus menyetujui Syarat dan Ketentuan';
                    isAggree = true;
                  });
                } else {
                  setState(() {
                    trems = '';
                    isAggree = false;
                  });
                }
                if (_formKey.currentState!.validate()) {
                  if (termsConditions == false) {
                    setState(() {
                      trems = 'Anda harus menyetujui Syarat dan Ketentuan';
                      isAggree = true;
                    });
                  } else {
                    setState(() {
                      trems = '';
                      isAggree = false;
                    });

                    var user = KAIUser(
                        "",
                        userNameController.text,
                        nameController.text,
                        emailController.text,
                        phoneController.text,
                        passController.text,
                        confirmController.text,
                        "",
                        accType);
                    var result =
                        await state.onRegisterAcc(user, termsConditions);

                    setState(() {
                      userNameErr = result["username"] ?? [];
                      emailErr = result["email"] ?? [];
                      nameErr = result["name"] ?? [];
                      phoneErr = result["phone"] ?? [];
                      passErr = result["password"] ?? [];
                      termsNConsAgreementErr =
                          result["terms_n_cons_agreement"] ?? [];

                      if (userNameErr.isNotEmpty) {
                        userNameErrStr = userNameErr[0];
                      }
                      if (emailErr.isNotEmpty) {
                        emailErrStr = emailErr[0];
                      }
                      if (nameErr.isNotEmpty) {
                        nameErrStr = nameErr[0];
                      }
                      if (phoneErr.isNotEmpty) {
                        phoneErrStr = phoneErr[0];
                      }
                      if (passErr.isNotEmpty) {
                        passErrStr = passErr[0];
                      }
                      if (termsNConsAgreementErr.isNotEmpty) {
                        termsNConsAgreementErrStr = termsNConsAgreementErr[0];
                      }
                    });

                    if (userNameErrStr.isNotEmpty ||
                        emailErrStr.isNotEmpty ||
                        nameErrStr.isNotEmpty ||
                        phoneErrStr.isNotEmpty ||
                        passErrStr.isNotEmpty ||
                        termsNConsAgreementErrStr.isNotEmpty) {
                      await showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                          ),
                        ),
                        isScrollControlled: true,
                        context: context,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                    emailErrStr != ''
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0, right: 18.0),
                                            child: Text(
                                              'Email: ' + emailErrStr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        : const Text(
                                            '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                    phoneErrStr != ''
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0, right: 18.0),
                                            child: Text(
                                              'Nomor telepon: ' + phoneErrStr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        : const Text(
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

                  // runZonedGuarded(() {
                  //   var user = KAIUser(
                  //       "",
                  //       userNameController.text,
                  //       nameController.text,
                  //       emailController.text,
                  //       phoneController.text,
                  //       passController.text,
                  //       confirmController.text,
                  //       "",
                  //       accType
                  //   );
                  //   state.onRegisterAccount(user);
                  // }, (error, stack) {
                  //   if (error is ConnectionErrorException) {
                  //     showError(error.cause);
                  //   } else {
                  //     showError(error.toString());
                  //   }
                  // });
                }
              },
              buttonColor: KaiColor.blue,
              textColor: Colors.white,
              sideColor: KaiColor.blue,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 38.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah punya akun? '),
                  GestureDetector(
                    onTap: () => state.onBackButton(),
                    child: const Text(
                      'Login disini',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: KaiColor.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0))
          ],
        ),
      )),
    );
  }
}
