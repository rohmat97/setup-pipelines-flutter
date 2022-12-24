import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/arguments/select_payment_method_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/selected_payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/pages/05selected_payment_page.dart';
import 'package:kai_wisata/kai_reguler/providers/select_payment_method_state.dart';
import 'package:kai_wisata/widgets/payment_methods_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectPaymentMethodPage extends StatefulWidget {
  static const routeName = '/select-payment-method-pages';
  const SelectPaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<SelectPaymentMethodPage> createState() => _SelectPaymentMethodPageState();
}

class _SelectPaymentMethodPageState extends State<SelectPaymentMethodPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SelectPaymentMethodState state = SelectPaymentMethodState();
  bool isLoaded = false;
  String iconBanks = '';
  int selectedIndex = 0;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    var res = await state.paymentMethods();
    if (res) {
      setState(() {
        isLoaded = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as SelectPaymentMethodArguments;

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
                          // onTap: () => state.onBackButton(),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pilih Metode Pembayaran",
                            style: KaiTextStyle.titleSmallBold
                                .apply(color: KaiColor.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: isLoaded == true ? state.payments.map((pm) {
                        var logos = pm.name!.split(" ");
                        iconBanks = 'assets/images/bank_${logos[0].toLowerCase()}.png';

                        return Container(
                          margin: const EdgeInsets.only(left: 18, right: 18, top: 10),
                          child: PaymentMethodsWidget(
                            name: pm.name!,
                            paths: iconBanks,
                            selectedIndex: pm.id! == selectedIndex,
                            onTap: () async {
                              setState(() {
                                selectedIndex = pm.id!;
                              });
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              var trxObj = {
                                "transaction_id": args.transactionId,
                                "payment_method_id": selectedIndex,
                              };
                              var methodObj = {
                                "id": pm.id,
                                "name": pm.name,
                                "type": pm.type,
                              };
                              sharedPreferences.setString("trx_obj", json.encode(trxObj));
                              sharedPreferences.setString("method_obj", json.encode(methodObj));
                              Navigator.pushNamed(context, SelectedPaymentPage.routeName, arguments: SelectedPaymentArguments(args.schedule, args.bookingCart, args.bookingCode, args.transactionId));
                            },
                          ),
                        );
                      }).toList() : [],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}