import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_istimewa/providers/special_customer_state.dart';
import 'package:kai_wisata/kai_wisata/widgets/tourism_phone_number.dart';
import 'package:kai_wisata/kai_wisata/widgets/tourism_text_field.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../arguments/special_arguments.dart';

class SpecialCustomerPage extends StatefulWidget {
  static const routeName = '/special-customer-pages';

  const SpecialCustomerPage({Key? key}) : super(key: key);

  @override
  State<SpecialCustomerPage> createState() => _SpecialCustomerPageState();
}

class _SpecialCustomerPageState extends State<SpecialCustomerPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SpecialCustomerState state = SpecialCustomerState();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController instanceController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool check1 = false;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    nameController.text = 'Mareto';
    emailController.text = 'maretoajah@gmail.com';
  }

  Widget tileDivider({double width = 22}) {
    return VerticalDivider(
      width: width,
      thickness: .25,
      color: KaiColor.white,
    );
  }

  buildIndicator() {
    return [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(top: 10),
            child: const LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [KaiColor.primary],
              strokeWidth: 2,
              backgroundColor: KaiColor.neutral11,
              pathBackgroundColor: KaiColor.neutral11,
            ),
          ),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {

    final args =
    ModalRoute.of(context)!.settings.arguments as SpecialArguments;

    state = Provider.of<SpecialCustomerState>(context);
    state.initState(context, scaffoldKey, args);

    nameController.text = state!.name;
    phoneController.text = state!.phone;
    emailController.text = state!.email;
    instanceController.text = state!.company;
    addressController.text = state!.address;

    return Scaffold(
      backgroundColor: KaiColor.neutral11,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: KaiColor.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                          20.0,
                        ),
                        child: InkWell(
                          child: SvgPicture.asset(
                            'assets/svg/arrow_left.svg',
                            height: 18,
                          ),
                          onTap: () => state.onBackButton(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                            instanceController.text,
                            addressController.text,
                          ),
                        ),
                      ),
                      Text(
                        'Data Pemesan',
                        style: KaiTextStyle.titleSmallBold
                            .apply(color: KaiColor.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 18,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 9.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Nama Pemesan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        TourismTextField(
                          textController: nameController,
                          hint: 'Nama',
                          obscure: false,
                          widget: const Text(''),
                          color: KaiColor.neutral11,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Alamat Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        TourismTextField(
                          textController: emailController,
                          hint: 'Email',
                          obscure: false,
                          widget: const Text(''),
                          color: KaiColor.neutral11,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Nomor Handphone (WA)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 18.0,
                                  right: 18.0,
                                ),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: KaiColor.black),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '+62',
                                      style: KaiTextStyle.bodyLargeMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: TourismPhoneNumber(
                                textController: phoneController,
                                hint: '81234567890',
                                obscure: false,
                                widget: const Text(''),
                                color: KaiColor.neutral11,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Nama Instansi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        TourismTextField(
                          textController: instanceController,
                          hint: 'Perusahaan A',
                          obscure: false,
                          widget: const Text(''),
                          color: KaiColor.neutral11,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Alamat Instansi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        TourismTextField(
                          textController: addressController,
                          hint: 'Jakarta Utara',
                          obscure: false,
                          widget: const Text(''),
                          color: KaiColor.neutral11,
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                              right: 18.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: KaiColor.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18.0,
                                      right: 18.0,
                                    ),
                                    child: RichText(
                                      text: const TextSpan(
                                        text:
                                            'Dengan ini saya setuju dan mematuhi syarat dan ketentuan pemesanan ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: KaiColor.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'PT Kereta Api Indonesia (Persero) ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: KaiColor.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'termasuk pembayaran dan mematuhi semua peraturan dan batasan mengenai ketersediaan tarif atau layanan.',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: KaiColor.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18.0,
                                      right: 18.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Checkbox(
                                            checkColor: KaiColor.white,
                                            activeColor: KaiColor.blue,
                                            value: check1,
                                            onChanged: (value) {
                                              setState(() {
                                                check1 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: RichText(
                                            text: const TextSpan(
                                              text:
                                                  'Saya telah membaca dan setuju terhadap ',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: KaiColor.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Syarat dan Ketentuan pembelian tiket',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: KaiColor.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        KaiButton(
                          text: 'Submit',
                          onClick: () => state.onBackButton(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                            instanceController.text,
                            addressController.text,
                          ),
                          buttonColor: KaiColor.blue,
                          textColor: KaiColor.white,
                          sideColor: KaiColor.blue,
                        ),
                      ],
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
