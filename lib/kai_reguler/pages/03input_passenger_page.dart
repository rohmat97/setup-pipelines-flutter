import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/arguments/input_passenger_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/providers/input_passenger_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';
import 'package:kai_wisata/widgets/kai_flex_button.dart';
import 'package:kai_wisata/kai_reguler/widgets/kai_order_detail.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:kai_wisata/widgets/kai_transparent_button.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../data/models/station.dart';
import '../models/caches/station_caches.dart';
import '../models/rail_booking.dart';
import '../models/rail_schedule.dart';

class InputPassengerPage extends StatefulWidget {
  static const routeName = '/input-passenger-pages';

  const InputPassengerPage({Key? key}) : super(key: key);

  @override
  State<InputPassengerPage> createState() => _InputPassengerPageState();
}

class _InputPassengerPageState extends State<InputPassengerPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  InputPassengerState state = InputPassengerState();
  PassengerCart? passengerDatas;

  TextEditingController phoneController = TextEditingController();

  Widget tileDivider({double height = 22}) {
    return Divider(
      height: height,
      thickness: .25,
      color: KaiColor.black,
    );
  }

  Widget orderData() {
    return Container(
      decoration: const BoxDecoration(
        color: KaiColor.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 18.0,
              left: 18.0,
              right: 18.0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: KaiColor.blue.withOpacity(0.1),
                  radius: 25.0,
                  child: const Image(
                    image: AssetImage('assets/images/ic_account.png'),
                    color: KaiColor.blue,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Aditya Bayu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'andrew@calibreworks.com',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: KaiColor.black.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          tileDivider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: KaiTextField(
              widget: const Text(''),
              obscure: false,
              textController: phoneController,
              hint: 'Phone Number',
              color: KaiColor.homeBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderReview(InputPassengerState state) {
    return Container(
      decoration: const BoxDecoration(
        color: KaiColor.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 18.0,
              left: 18.0,
              right: 18.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${state.vendor}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${state.longDate}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${state.timeAndStationDesc}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      SvgPicture.asset(
                        'assets/svg/elipse.svg',
                        color: KaiColor.black.withOpacity(0.5),
                        height: 3.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          tileDivider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Passenger',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "${state.totalPassenger}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget passengerData() {
    return Container(
      decoration: const BoxDecoration(
        color: KaiColor.white,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 18.0,
              left: 18.0,
              right: 18.0,
            ),
            child: Text(
              'Match the customer data',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: KaiColor.blue,
              ),
            ),
          ),
          tileDivider(),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 18.0,
              left: 18.0,
              right: 18.0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: KaiColor.blue.withOpacity(0.1),
                  radius: 18.0,
                  child: SvgPicture.asset(
                    'assets/svg/plus.svg',
                    height: 18,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  'fill in passenger data1',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget additional() {
    return Container(
      decoration: const BoxDecoration(
        color: KaiColor.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 18.0,
              right: 18.0,
              bottom: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/baggage.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text(
                      'Buy additional baggage',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/svg/plus.svg',
                  height: 18,
                ),
              ],
            ),
          ),
          Container(
            height: 20.0,
            decoration: const BoxDecoration(
              color: KaiColor.homeBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSheet() {
    return Container(
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
          const Padding(
            padding: EdgeInsets.only(
              top: 30.0,
            ),
            child: Text(
              'Make sure your order is filled correctly',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          orderReview(state),
          Row(
            children: [
              KaiCustomButton(
                text: 'Check Again',
                onClick: () {},
                buttonColor: KaiColor.blue.withOpacity(0.1),
                textColor: KaiColor.blue,
                sideColor: KaiColor.blue.withOpacity(0.1),
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
              ),
              KaiCustomButton(
                text: 'Next',
                onClick: () async => state.bookCart(),
                buttonColor: KaiColor.blue,
                textColor: KaiColor.white,
                sideColor: KaiColor.blue,
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildPassengerCard(PassengerCart passenger){
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
              left: 18.0, top: 10.0, bottom: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Data Penumpang',
              style: KaiTextStyle.bodySmallBold,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        KaiTransparentButton(
          text: "$passenger",
          onClick: () {
            state.onPassengerTap(passenger);
          },
          buttonColor: KaiColor.neutral11,
          textColor: KaiColor.black,
          sideColor: KaiColor.neutral6,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 18.0,
            top: 10.0,
            right: 18.0,
          ),
          child: Divider(
            color: KaiColor.black,
          ),
        ),
      ],
    );
  }

  Widget buildListPassenger(List<PassengerCart> passengers){
    return Expanded(
      flex: 6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  left: 18.0, top: 10.0, bottom: 10.0),
              child: Text(''),
            ),
            KaiOrderDetail(
              schedule: state.args!.schedule,
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 18.0, top: 10.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Data Pemesan',
                  style: KaiTextStyle.bodySmallBold,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            KaiTransparentButton(
              text: '${state.bookingInfo.dataCallerCart}',
              onClick: () => state.onOrderTap(),
              buttonColor: KaiColor.neutral11,
              textColor: KaiColor.black,
              sideColor: KaiColor.neutral6,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: passengers.length,
              itemBuilder: (context, index) {
                return buildPassengerCard(passengers[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showError(String error){
    Alert(
      context: context,
      type: AlertType.error,
      title: "ERROR",
      desc: error,
      buttons: [
        DialogButton(
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute
        .of(context)!
        .settings
        .arguments as InputPassengerArguments;

    state = Provider.of<InputPassengerState>(context);
    state.initState(context, scaffoldKey, args);

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
                          onTap: () => state.onBackButton(),
                        ),
                      ),
                      Text(
                        'Lengkapi Data',
                        style: KaiTextStyle.titleSmallBold
                            .apply(color: KaiColor.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: KaiColor.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        circleNumber('1', KaiColor.blue),
                        Text(
                          'Pesan',
                          style: KaiTextStyle.bodySmallBold.apply(
                            color: KaiColor.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 40.0,
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        circleNumber('2', KaiColor.grey),
                        Text(
                          'Review',
                          style: KaiTextStyle.bodySmallBold.apply(
                            color: KaiColor.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 40.0,
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        circleNumber('3', KaiColor.grey),
                        Text(
                          'Bayar',
                          style: KaiTextStyle.bodySmallBold.apply(
                            color: KaiColor.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                buildListPassenger(state.bookingInfo.adults),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: KaiFlexButton(
                          text: 'Lanjut',
                          onClick: () =>
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
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              top: 30.0,
                                            ),
                                            child: Text(
                                              'Make sure your order is filled correctly',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          orderReview(state),
                                          Row(
                                            children: [
                                              KaiCustomButton(
                                                text: 'Check Again',
                                                onClick: () =>
                                                    state.onBackButton(),
                                                buttonColor:
                                                KaiColor.blue.withOpacity(0.1),
                                                textColor: KaiColor.blue,
                                                sideColor:
                                                KaiColor.blue.withOpacity(0.1),
                                                width:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    0.4,
                                                height: 40,
                                              ),
                                              KaiCustomButton(
                                                text: 'Next',
                                                onClick: () {
                                                  try {
                                                    state.onNext();
                                                  } catch (e) {
                                                    showError(e.toString());
                                                  }
                                                },
                                                buttonColor: KaiColor.blue,
                                                textColor: KaiColor.white,
                                                sideColor: KaiColor.blue,
                                                width:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    0.4,
                                                height: 40,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                              ),
                          buttonColor: KaiColor.blue,
                          textColor: KaiColor.white,
                          sideColor: KaiColor.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  circleNumber(String number, Color color) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // You can use like this way or like the below line
        //borderRadius: new BorderRadius.circular(30.0),
        color: color,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          number,
          style: KaiTextStyle.bodySmallMedium.apply(color: KaiColor.white),
        ),
      ),
    );
  }
}
