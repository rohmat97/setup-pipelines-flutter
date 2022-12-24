import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/flights/arguments/flight_booking_arguments.dart';
import 'package:kai_wisata/flights/models/flight_payment_method_model.dart';
import 'package:kai_wisata/flights/providers/flight_booking_state.dart';
import 'package:kai_wisata/flights/providers/flight_doku_state.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_other_button.dart';
import 'package:kai_wisata/widgets/payment_methods_widget.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:shared_preferences/shared_preferences.dart';

class FlightBookingPage extends StatefulWidget {
  static const routeName = '/flight-booking-pages';

  const FlightBookingPage({Key? key}) : super(key: key);

  @override
  State<FlightBookingPage> createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  FlightBookingState? state;
  FlightDokuState stateDk = FlightDokuState();
  List<FlightPaymentMethodModel> payments = [];

  String defaultArea = "812";
  TextEditingController idMethodController = TextEditingController();
  String? iconBanks;
  int selectedIndex = 0;

  Map<String, dynamic> reqDoku = {};

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    FlightBookingState state = Provider.of<FlightBookingState>(context, listen: false);
    var getPayMethod = await state.getPaymentMethod();

    if (getPayMethod) {
      // print(json.encode(state.payments));
      for (var pm in state.payments) {
        setState(() {
          payments.add(pm);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FlightBookingArguments;

    FlightBookingState state = Provider.of<FlightBookingState>(context);
    state.initState(context, scaffoldKey);

    var htmlData = 'r"""' + args.booking!.detail! + '"""';
    print(args.booking!.transactionId);
    
    if (payments.isEmpty) {
      for (var pm in state.payments) {
        payments.add(pm);
      }
    }

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
                          onTap: () => state.onBackHome(),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Booking Page",
                            style: KaiTextStyle.titleSmallBold
                                .apply(color: KaiColor.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Card(
                            child: Center(
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width,
                                      child: const Text(
                                        'Sukses Booking',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Kode Booking',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          Text(
                                            '${args.booking!.bookingCode}',
                                            // 'A9YOHI',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Waktu Limit',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          Text(
                                            DateFormat("EEEE, d MMM yyyy HH:mm", "id_ID").format(args.booking!.timeLimit!),
                                            // '2022-11-27 03:33:09',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18, left: 18, right: 18),
                          child: Card(
                            child: Center(
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width,
                                      child: const Text(
                                        'Pilih Pembayaran',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Anda dapat membayar dengan transfer melalui ATM, Internet Banking & Mobile Banking',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            padding: const EdgeInsets.only(top: 18, bottom: 8),
                                            child: Wrap(
                                              children: payments.map((e) {
                                                var logos = e.name!.split(" ");

                                                setState(() {
                                                  iconBanks = 'assets/images/bank_${logos[0].toLowerCase()}.png';
                                                });

                                                return PaymentMethodsWidget(
                                                  name: e.name!,
                                                  paths: '$iconBanks',
                                                  selectedIndex: e.id! == selectedIndex,
                                                  onTap: () async {
                                                    setState(() {
                                                      selectedIndex = e.id!;
                                                    });
                                                    var reqGenCode = {
                                                      'transaction_id': args.booking!.transactionId,
                                                      'payment_method_id': e.id,
                                                    };

                                                    reqDoku.addAll(reqGenCode);
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: KaiColor.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 18, top: 8, bottom: 8),
                            child: KaiOtherButton(
                              text: 'Bayar Sekarang!',
                              onClick: () async {
                                var toDoku = await state.payDoku(reqDoku);
                                if (toDoku) {
                                  state.onNextButton();
                                }
                              },
                              buttonColor: KaiColor.blue,
                              textColor: KaiColor.white,
                              sideColor: KaiColor.blue,
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 18, top: 8, bottom: 8),
                            child: KaiOtherButton(
                              text: 'Bayar Nanti Saja!',
                              onClick: () async {
                                state.onBackHome();
                              },
                              buttonColor: KaiColor.red,
                              textColor: KaiColor.white,
                              sideColor: KaiColor.blue,
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
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