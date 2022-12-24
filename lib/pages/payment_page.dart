import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/payment_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_payment_method.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  static const routeName = '/payment-pages';

  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PaymentState state = PaymentState();

  TextEditingController phoneController = TextEditingController();

  Widget tileDivider({double height = 22}) {
    return Divider(
      height: height,
      thickness: .25,
      color: KaiColor.black,
    );
  }

  Widget bankTransfer() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KaiColor.white,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 12.0,
                left: 18.0,
                right: 18.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Mandiri Bank'),
              ),
            ),
            tileDivider(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                left: 18.0,
                right: 18.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'See All',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: KaiColor.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SvgPicture.asset(
                    'assets/svg/drop_down.svg',
                    color: KaiColor.blue,
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
    state = Provider.of<PaymentState>(context);
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
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('Bank Transfer'),
                      ),
                      bankTransfer(),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('Credit Card'),
                      ),
                      const KaiPaymentMethod(method: 'Credit Card/Debit'),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('ATM Transfer'),
                      ),
                      const KaiPaymentMethod(method: 'ATM'),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('Internet Banking'),
                      ),
                      const KaiPaymentMethod(method: 'KlikBCA'),
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
                text: 'Next',
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
