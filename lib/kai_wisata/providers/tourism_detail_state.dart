import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_wisata/arguments/tourism_detail_arguments.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_customer.dart';
import 'package:kai_wisata/kai_wisata/pages/tourism_customer_page.dart';
import 'package:kai_wisata/kai_wisata/services/wisata_services.dart';
// import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:kai_wisata/home/pages/transaction_history_page.dart';

import '../arguments/tourism_customer_arguments.dart';

class TourismDetailState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  TourismCustomerArguments? args;

  TourismCustomer? cust;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
    TourismCustomerArguments args,
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
    cust = args.customer;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onCustomerSelected() {
    Navigator.pushNamed(context!, TourismCustomerPage.routeName,
        arguments: TourismCustomerArguments(
            args!.searchArguments, args!.schedule, args!.wagon, cust!));
  }

  void onFinishButton() {
    Navigator.pushNamed(context!, TransactionHistoryPage.routeName);
  }

  book(String seat, String note) async {
    var newCust = TourismCustomer(cust!.name, cust!.email, cust!.phone,
        cust!.company, cust!.address, int.parse(seat), note);

    await WisataService.book(
      args!.searchArguments,
      args!.schedule,
      args!.wagon,
      newCust,
      seat,
      note,
    );
  }
}
