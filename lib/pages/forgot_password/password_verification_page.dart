import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/forgot_password/password_verification_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:provider/provider.dart';

class PasswordVerificationPage extends StatefulWidget {
  static const routeName = '/password-verification-pages';

  const PasswordVerificationPage({Key? key}) : super(key: key);

  @override
  State<PasswordVerificationPage> createState() =>
      _PasswordVerificationPageState();
}

class _PasswordVerificationPageState extends State<PasswordVerificationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PasswordVerificationState state = PasswordVerificationState();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    state = Provider.of<PasswordVerificationState>(context);
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
                top: 18.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Text(
                'Masukkan kode verifikasi sesuai email yang telah kami kirim',
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
                  'Kode Verifikasi',
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
              text: 'Konfirmasi',
              onClick: () => state.onButtonPressed(),
              buttonColor: KaiColor.blue,
              textColor: Colors.white,
              sideColor: KaiColor.blue,
            ),
          ],
        ),
      ),
    );
  }
}
