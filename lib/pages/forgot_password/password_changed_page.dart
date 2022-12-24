import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/forgot_password/password_changed_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:provider/provider.dart';

class PasswordChangedPage extends StatefulWidget {
  static const routeName = '/password-changed-pages';

  const PasswordChangedPage({Key? key}) : super(key: key);

  @override
  State<PasswordChangedPage> createState() => _PasswordChangedPageState();
}

class _PasswordChangedPageState extends State<PasswordChangedPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PasswordChangedState state = PasswordChangedState();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    state = Provider.of<PasswordChangedState>(context);
    state.initState(context, scaffoldKey);
    return Scaffold(
      backgroundColor: KaiColor.white,
      appBar: AppBar(
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
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              child: Image.asset(
                'assets/images/password_changed.png',
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.fill,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 18.0,
                left: 18.0,
                right: 18.0,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Password Kamu Berhasil Diganti!',
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
                'Mulai sekarang kamu bisa login dengan password baru kamu',
                textAlign: TextAlign.center,
              ),
            ),
            KaiButton(
              padding: const EdgeInsets.all(18.0),
              text: 'Lanjutkan Login',
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
