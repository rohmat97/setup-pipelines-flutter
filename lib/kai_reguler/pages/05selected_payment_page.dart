import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/flights/models/flight_payment_method_model.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/providers/selected_payment_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_loading_indicator.dart';
import 'package:kai_wisata/widgets/kai_transparent_button.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../arguments/selected_payment_arguments.dart';
import 'package:intl/intl.dart';

class SelectedPaymentPage extends StatefulWidget {
  static const routeName = '/selected-payment-pages';

  const SelectedPaymentPage({Key? key}) : super(key: key);

  @override
  State<SelectedPaymentPage> createState() => _SelectedPaymentPageState();
}

class _SelectedPaymentPageState extends State<SelectedPaymentPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SelectedPaymentState state = SelectedPaymentState();

  TextEditingController accountController = TextEditingController();

  FlightPaymentMethodModel? payment;
  Map<String, dynamic> trxObject = {};

  List<String> seat = [];

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var trxObj = sharedPreferences.getString("trx_obj");
    var methodObj = sharedPreferences.getString("method_obj");

    if (methodObj != "") {
      setState(() {
        var toMthdObj = json.decode(methodObj!);
        payment = FlightPaymentMethodModel.fromJson(toMthdObj);
      });
    }
    if (trxObj != null) {
      var toObjTrx = json.decode(trxObj);
      setState(() {
        trxObject.addAll(toObjTrx);
      });
    }
  }

  Widget tileDivider({double height = 22}) {
    return Divider(
      height: height,
      thickness: .25,
      color: KaiColor.black,
    );
  }

  Widget yourOrder() {
    // print(state.bookingInfo?.toJson());
    for (var st in state.bookingInfo!.routeInfo) {
      setState(() {
        seat = st.tickets.map<String>((e) => e.seat).toList();
      });
    }
    
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: KaiColor.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 18, top: 10),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Your Order',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: KaiColor.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 18),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                         Text(
                          "${state.args?.bookingCart.departHour}",
                          style: KaiTextStyle.titleSmallBold,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KaiColor.homeBackground.withOpacity(0.8),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                              right: 5.0,
                              top: 1.0,
                              bottom: 1.0,
                            ),
                            child: Text(
                              "${state.args?.bookingCart.org}",
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      children: [
                        const Text(
                          '1h 50m',
                          style: TextStyle(
                            fontSize: 8.0,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/elipse.svg',
                              width: 8.0,
                            ),
                            SvgPicture.asset(
                              'assets/svg/line.svg',
                              width: 40.0,
                            ),
                            SvgPicture.asset(
                              'assets/svg/elipse.svg',
                              width: 8.0,
                            ),
                          ],
                        ),
                        const Text(
                          'Direct',
                          style: TextStyle(
                            fontSize: 8.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      children: [
                        Text(
                          "${state.args?.bookingCart.arrivHour}",
                          style: KaiTextStyle.titleSmallBold,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KaiColor.homeBackground.withOpacity(0.8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                              right: 5.0,
                              top: 1.0,
                              bottom: 1.0,
                            ),
                            child: Text(
                              "${state.args?.bookingCart.des}",
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 18),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/train.svg',
                      height: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          "${state.args?.schedule.vendor}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: KaiColor.black,
                          ),
                        ),
                        Row(
                          children: [
                             Text(
                              "${state.args?.schedule.kelas}",
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: KaiColor.black,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            SvgPicture.asset(
                              'assets/svg/elipse.svg',
                              color: KaiColor.black,
                              height: 3.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Text(
                              'Direct',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: KaiColor.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Departure Date - ${state.args?.bookingCart.shortFromDate}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: KaiColor.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 18, bottom: 10),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: const Text(
              'Details',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: KaiColor.blue,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
                left: 18.0, top: 10.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pilih Kursi',
                style: KaiTextStyle.bodySmallBold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: KaiTransparentButton(
              text: seat.join(', '),
              onClick: () async {
                state.selectSeatButton();
              },
              buttonColor: KaiColor.neutral11,
              textColor: KaiColor.black,
              sideColor: KaiColor.neutral6,
            ),
          ),
        ],
      ),
    );
  }

  Widget accountOwner() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Account owner's name",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
              child: TextFormField(
                readOnly: true,
                controller: accountController,
                onChanged: (value) {},
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(8),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    hintText: 'Aditya Indra Bayu'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentMethod() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: KaiColor.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 18, top: 10),
                  // width: double.infinity / 2,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: KaiColor.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 18, top: 10),
                  // width: double.infinity / 2,
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      state.onSelectPaymentMethod();
                    },
                    child: const Text(
                      'Choose Method',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: KaiColor.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, top: 8),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                payment?.name == null ? "Pilih Pembayaran Terlebih dulu!" : "${payment?.name}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: KaiColor.black,
                ),
              ),
            ),
            tileDivider(),
            // accountOwner(),
            // couponCode(),
            // pricingDetails()
          ],
        ),
      ),
    );
  }

  Widget couponCode() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: KaiColor.white,
        ),
        child: Container(
          padding: const EdgeInsets.only(
            top: 10.0,
            right: 18.0,
            left: 18.0,
            bottom: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/coupon.svg',
                    height: 20.0,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    'Coupon Code',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: KaiColor.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const Text(
                'Use Coupon',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: KaiColor.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pricingDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: KaiColor.white,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 18, top: 10),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: const Text(
                'Pricing Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: KaiColor.black,
                ),
              ),
            ),
            tileDivider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${state.args?.schedule.vendor}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black.withOpacity(0.5),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Adult Passenger',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "${state.args?.bookingCart.adults.length}x",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "Rp ${state.bookingInfo?.routeInfo[0].basicFareFormatted}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  tileDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Additional Fee',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "Rp ${state.bookingInfo?.routeInfo[0].additionalFeeFormatted}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              decoration: const BoxDecoration(
                color: KaiColor.yellow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text(
                    'Price Total',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black,
                    ),
                  ),
                  Text(
                    "Rp ${state.bookingInfo?.routeInfo[0].totalFormatted}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: KaiColor.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              decoration: const BoxDecoration(
                color: KaiColor.white,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '*The number will be deducted by the unique code on the instruction pages',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: KaiColor.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: KaiColor.yellow,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'complete the order in ',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        DateFormat("HH:mm").format(
                            state.bookingInfo!.timeLimit),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 19,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    yourOrder(),
                    couponCode(),
                    tileDivider(),
                    paymentMethod(),
                    pricingDetails(),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: KaiButton(
              text: 'Pay Now',
              onClick: () => state.onNextButton(trxObject),
              buttonColor: KaiColor.blue,
              textColor: KaiColor.white,
              sideColor: KaiColor.blue,
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: KaiColor.white,
          size: 40.0,
        ),
        onPressed: () => state.onBackButton(),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      ),
      title: Text(
        'Review',
        style: KaiTextStyle.titleSmallBold.apply(color: KaiColor.white),
      ),
      backgroundColor: KaiColor.blue,
      centerTitle: true,
      actions: [
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as SelectedPaymentArguments;

    state = Provider.of<SelectedPaymentState>(context);
    state.initState(context, scaffoldKey, args);
    state.getBookingInfoOnce();

    return Scaffold(
      appBar: buildAppBar(),
      body: (state.isLoaded) ? buildBody() : const KaiLoadingIndicator()
    );
  }
}
