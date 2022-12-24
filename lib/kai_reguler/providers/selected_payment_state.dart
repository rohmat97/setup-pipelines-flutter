import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/doku_payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/select_payment_method_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/select_seat_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/selected_payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';
import 'package:kai_wisata/kai_reguler/pages/select_payment_method_page.dart';
import 'package:kai_wisata/kai_reguler/pages/select_seat_page.dart';
import 'package:kai_wisata/kai_reguler/services/regular_ticket_service.dart';

import 'package:intl/intl.dart';

import '../pages/06doku_payment_page.dart';

class SelectedPaymentState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  SelectedPaymentArguments? args;
  RailBookingInfo? bookingInfo;
  bool isLoaded = false;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey, SelectedPaymentArguments args,) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void onSelectPaymentMethod() {
    var arg = SelectPaymentMethodArguments(args!.schedule, args!.bookingCart, args!.bookingCode, args!.transactionId);
    Navigator.pushNamed(context!, SelectPaymentMethodPage.routeName, arguments: arg);
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onNextButton(Map<String, dynamic> trxObj) async {
    var url = await RegularTicketService.createPayment(trxObj);

    Navigator.pushNamed(context!,
        DokuPaymentPage.routeName,
        arguments: DokuPaymentArguments(
            args!.schedule,
            args!.bookingCart,
            url)
    );
    //Navigator.pushNamed(context!, OrderedSuccessfullyPage.routeName);
  }

  void getBookingInfoOnce() async {

    if(!isLoaded) {
      bookingInfo = await RegularTicketService.getBookingInfo(args!.bookingCode);

      isLoaded = true;
      notifyListeners();
    }
  }

  void selectSeatButton() async {
    var arg = SelectSeatArguments(args!.schedule, args!.bookingCart, args!.bookingCode, args!.transactionId, bookingInfo!);
    await Navigator.pushNamed(context!, SelectSeatPage.routeName, arguments: arg);
  }
}
