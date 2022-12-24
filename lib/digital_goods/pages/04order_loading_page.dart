import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/pages/03goods_pulsa_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/05doku_payment_page.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';
import 'package:kai_wisata/kai_reguler/arguments/booking_loading_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/input_passenger_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/pages/03input_passenger_page.dart';
import 'package:kai_wisata/kai_reguler/pages/05selected_payment_page.dart';
import 'package:kai_wisata/widgets/kai_loading_indicator.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../helpers/theme.dart';
import '../arguments/goods_doku_arguments.dart';
import '../arguments/goods_order_loading_arguments.dart';
import '../arguments/pulsa_home_arguments.dart';
import '../models/buy_info.dart';

class GoodsOrderLoadingPage extends StatelessWidget {
  static const routeName = '/goods-order-loading-pages';
  GoodsOrderLoadingArguments? args;

  GoodsOrderLoadingPage({Key? key}) : super(key: key);

  void showError(BuildContext context, String error) {
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
          onPressed: () => Navigator.pushReplacementNamed(
              context, GoodsPulsaHomePage.routeName,
              arguments: PulsaHomeArguments(args!.brand)),
          width: 120,
        )
      ],
    ).show();
  }

  void book(BuildContext context, BuyInfo buyinfo) async {
    try {
      var url = await EGoodsServies.buy(buyinfo);
      if (url != "") {
        // Navigator.pushReplacementNamed(context, GoodsDokuPaymentPage.routeName,
        //     arguments: GoodsDokuArguments(url));
      } else {
        showError(context,
            "Error on booking the ticket, please contact administrator");
      }
    } catch (e) {
      showError(context, "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments
        as GoodsOrderLoadingArguments;
    book(context, args!.buyInfo);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Please Wait ...',
            style: KaiTextStyle.titleSmallBold.apply(color: KaiColor.white),
          ),
          backgroundColor: KaiColor.blue,
          centerTitle: true,
        ),
        body: const KaiLoadingIndicator());
  }
}
