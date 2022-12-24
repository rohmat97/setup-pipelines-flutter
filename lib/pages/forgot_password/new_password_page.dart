import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/forgot_password/new_password_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:provider/provider.dart';

class NewPasswordPage extends StatefulWidget {
  static const routeName = '/new-password-pages';

  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  NewPasswordState state = NewPasswordState();

  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  late bool visibility1 = true;
  late bool visibility2 = true;

  @override
  Widget build(BuildContext context) {
    state = Provider.of<NewPasswordState>(context);
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
                  'Password Baru',
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
                'Masukkan Password baru dan ulangi untuk mengkonfirmasi passwordmu',
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
                  'Password Baru',
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
                textController: passController,
                hint: 'Masukkan password baru',
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
                  'Konfirmasi Password Baru',
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
                hint: 'Ulangi password baru',
                color: KaiColor.homeBackground,
              ),
            ),
            KaiButton(
              padding: const EdgeInsets.all(18.0),
              text: 'Buat Password Baru',
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
