import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/ordered_successfully_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:provider/provider.dart';

class FlightOrderedSuccessfullyPage extends StatefulWidget {
  static const routeName = '/ordered-successfully-pages';

  const FlightOrderedSuccessfullyPage({Key? key}) : super(key: key);

  @override
  State<FlightOrderedSuccessfullyPage> createState() =>
      _FlightOrderedSuccessfullyPageState();
}

class _FlightOrderedSuccessfullyPageState extends State<FlightOrderedSuccessfullyPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  OrderedSuccessfullyState state = OrderedSuccessfullyState();

  TextEditingController phoneController = TextEditingController();

  Widget tileDivider({double height = 22}) {
    return Divider(
      height: height,
      thickness: .25,
      color: KaiColor.black,
    );
  }

  Widget orderNumber() {
    return Container(
      decoration: const BoxDecoration(
        color: KaiColor.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 18,
              left: 18,
              top: 8,
              bottom: 8,
            ),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order Number:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: KaiColor.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '1345AADDQQ1211J',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      'COPY',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: KaiColor.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget payBefore() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: KaiColor.white,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: 18,
                left: 18,
                top: 8,
                bottom: 8,
              ),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pay Before:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: KaiColor.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Monday, 24 May 2021, 20:37 WIB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black,
                        ),
                      ),
                      Text(
                        'COPY',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: KaiColor.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transferTo() {
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
                'Transfer To:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: KaiColor.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 18,
                left: 18,
                top: 8,
                bottom: 8,
              ),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Account Number:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: KaiColor.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '123-456-789-000',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black,
                        ),
                      ),
                      Text(
                        'COPY',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: KaiColor.blue,
                        ),
                      ),
                    ],
                  ),
                  tileDivider(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Account Name:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: KaiColor.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'PT. KA WISATA INDONESIA',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black,
                        ),
                      ),
                    ],
                  ),
                  tileDivider(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: KaiColor.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Rp929.234',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black,
                        ),
                      ),
                      Text(
                        'COPY',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: KaiColor.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makingSure() {
    return Container(
      padding: const EdgeInsets.only(
        right: 18,
        left: 18,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: KaiColor.blue.withOpacity(0.1),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            backgroundColor: KaiColor.blue,
            radius: 10,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '!',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            'Make sure the nominal matches up to the last 3 digits',
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<OrderedSuccessfullyState>(context);
    state.initState(context, scaffoldKey);
    return Scaffold(
      appBar: AppBar(
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
          'Payment',
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
      ),
      body: Stack(
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
                      children: const [
                        Text(
                          'complete the order in ',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '00:44:31',
                          style: TextStyle(
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
                      orderNumber(),
                      payBefore(),
                      transferTo(),
                      makingSure(),
                      const Padding(
                        padding: EdgeInsets.all(35.0),
                        child: Text(
                          'After your payment is confirmed, we will send proof of the transaction and e-ticket to your email address (syelamarcela@gmail.com)',
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                text: 'Cek Order',
                onClick: () => state.onNextButton(),
                buttonColor: KaiColor.blue,
                textColor: KaiColor.white,
                sideColor: KaiColor.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
