import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/pages/05doku_payment_page.dart';
import 'package:kai_wisata/hotel/pages/01hotel_search_page.dart';
import 'package:kai_wisata/hotel/services/hotel_services.dart';
import 'package:kai_wisata/widgets/kai_loading_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../helpers/theme.dart';
import '../arguments/hotel_doku_arguments.dart';
import '../arguments/hotel_order_loading_arguments.dart';
import '../models/hotel_booking_info.dart';
import '08hotel_doku_payment_page.dart';

class HotelOrderLoadingPage extends StatelessWidget {

  static const routeName = '/hotel-order-loading-pages';
  HotelOrderLoadingArguments? args;

  HotelOrderLoadingPage({Key? key}) : super(key: key);

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
          onPressed: () =>
              Navigator.pushReplacementNamed(
                  context, HotelSearchPage.routeName),
          width: 120,
        )
      ],
    ).show();
  }

  void book(BuildContext context, HotelBookingInfo buyinfo) async {
    try {
      var url = await HotelServices.book(buyinfo);
      if (url != "") {
        Navigator.pushReplacementNamed(
            context,
            HotelDokuPaymentPage.routeName,
            arguments: DokuHotelArguments(url)
        );
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
    args = ModalRoute.of(context)!.settings.arguments as HotelOrderLoadingArguments;
    book(context, args!.info);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Please Wait ...',
          style: KaiTextStyle.titleSmallBold.apply(color: KaiColor.white),
        ),
        backgroundColor: KaiColor.blue,
        centerTitle: true,
      ),
      body: const KaiLoadingIndicator()
    );
  }
}