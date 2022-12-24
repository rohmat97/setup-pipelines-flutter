import 'package:flutter/material.dart';
// import 'package:kai_wisata/digital_goods/arguments/doku_payment_arguments.dart';
import 'package:kai_wisata/digital_goods/arguments/digital_goods_select_payment_method_arguments.dart';
import 'package:kai_wisata/digital_goods/arguments/digital_goods_selected_payment_arguments.dart';
import 'package:kai_wisata/digital_goods/arguments/goods_doku_arguments.dart';
import 'package:kai_wisata/digital_goods/pages/digital_goods_select_payment_method_page.dart';
import 'package:kai_wisata/digital_goods/pages/05doku_payment_page.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';
import 'package:kai_wisata/pages/ordered_successfully_page.dart';

// import '../pages/05doku_payment_page.dart';

class DigitalGoodsSelectedPaymentState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  DigitalGoodsSelectedPaymentArguments? args;
  bool isLoaded = false;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
    DigitalGoodsSelectedPaymentArguments args,
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void onSelectPaymentMethod() {
    var arg = DigitalGoodsSelectedPaymentArguments(
        args!.transaction,
        args!.tagihan,
        args!.transactionId,
        args!.nama,
        args!.adm,
        args!.tagihanListrik);
    Navigator.pushNamed(context!, DigitalGoodsSelectPaymentMethodPage.routeName,
        arguments: arg);
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onNextButton(Map<String, dynamic> trxObj) async {
    var url = await EGoodsServies.createPayment(trxObj);

    Navigator.pushNamed(context!, GoodsDokuPaymentPage.routeName,
        arguments: GoodsDokuArguments(url));

    // Navigator.pushNamed(context!, OrderedSuccessfullyPage.routeName);
  }

  // void getBookingInfoOnce() async {
  //   if (!isLoaded) {
  //     bookingInfo =
  //         await RegularTicketService.getBookingInfo(args!.bookingCode);

  //     isLoaded = true;
  //     notifyListeners();
  //   }
  // }

  // void selectSeatButton() async {
  //   await Navigator.pushNamed(context!, SelectSeatPage.routeName);
  // }
}
