import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/arguments/order_data_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/selected_payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/providers/order_details_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  static const routeName = '/order-details-pages';

  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  OrderDetailsState state = OrderDetailsState();

  TextEditingController phoneController = TextEditingController();

  Widget tileDivider({double height = 22}) {
    return Divider(
      height: height,
      thickness: .25,
      color: KaiColor.black,
    );
  }

  Widget waitingPayment() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18.0,
        right: 18.0,
        left: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KaiColor.white,
        ),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 18.0,
            bottom: 18.0,
            left: 8.0,
            right: 8.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: KaiColor.yellow.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/time.svg'),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text(
                          'Waiting for payment in 00:53:45',
                          style: TextStyle(
                            color: KaiColor.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Payment Method : Bank Transfer Mandiri',
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ),
              KaiButton(
                padding: const EdgeInsets.all(8),
                text: 'See payment instructions',
                onClick: () {},
                buttonColor: KaiColor.blue,
                textColor: KaiColor.white,
                sideColor: KaiColor.blue,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Order Number:',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '1345AADDQQ1211J',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: KaiColor.blue,
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
      ),
    );
  }

  Widget transportDetails() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 18.0,
        left: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KaiColor.white,
        ),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 18.0,
            bottom: 18.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/plane.svg',
                    height: 20.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Batik + Scoot',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: KaiColor.black,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Economy',
                            style: TextStyle(
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
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.chevron_right,
                color: KaiColor.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceDetails() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 18.0,
        left: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KaiColor.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 14.0,
                left: 10.0,
                right: 10.0,
                bottom: 14.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Price Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Text(
                        'Rp929.234',
                        style: TextStyle(color: KaiColor.blue),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: KaiColor.blue,
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

  Widget passengerData() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 18.0,
        left: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KaiColor.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 14.0,
                left: 10.0,
                right: 10.0,
                bottom: 14.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Passenger Data',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: KaiColor.blue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mr. Aditya Bayu',
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: KaiColor.homeBackground.withOpacity(0.8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            top: 1.0,
                            bottom: 1.0,
                          ),
                          child: Text(
                            'Adult',
                            style: TextStyle(fontSize: 10),
                          ),
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

  @override
  Widget build(BuildContext context) {

    state = Provider.of<OrderDetailsState>(context);
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
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jakarta ',
                  style:
                      KaiTextStyle.titleSmallBold.apply(color: KaiColor.white),
                ),
                SvgPicture.asset(
                  "assets/svg/arrow.svg",
                  color: KaiColor.white,
                  height: 12.0,
                ),
                Text(
                  ' Singapore',
                  style:
                      KaiTextStyle.titleSmallBold.apply(color: KaiColor.white),
                ),
              ],
            ),
            Text(
              'Order Number : 1345AADDQQ1211J',
              style: KaiTextStyle.smallRegular.apply(color: KaiColor.white),
            ),
          ],
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
                flex: 19,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      waitingPayment(),
                      transportDetails(),
                      priceDetails(),
                      passengerData(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
