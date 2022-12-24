import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/home/pages/egoods_home_booking_page.dart';
import 'package:kai_wisata/home/pages/flight_home_booking_page.dart';
import 'package:kai_wisata/home/pages/rail_home_booking_page.dart';
import 'package:kai_wisata/home/pages/special_home_booking_page.dart';
import 'package:kai_wisata/home/pages/tourism_home_booking_page.dart';
import 'package:kai_wisata/pages/my_points_page.dart';
import 'package:kai_wisata/home/pages/transaction_history_page.dart';
import 'package:kai_wisata/home/pages/rail_booking_detail_page.dart';
import 'package:kai_wisata/user/models/auth_cache.dart';
import 'package:kai_wisata/user/pages/login_page.dart';
import 'package:kai_wisata/user/services/user_services.dart';

import '../../user/models/kai_user.dart';
import '../models/history_payment.dart';
import '../services/booking_service.dart';

class HomeAccountState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  ScrollController? scrollController;

  List<Transaction> histories = [];
  bool isLoaded = false;

  KAIUser? user;

  void init(
    BuildContext ctx, {
    GlobalKey<ScaffoldState>? scaffoldKey,
    ScrollController? scrollController,
  }) {
    context = ctx;
    key = scaffoldKey;
    this.scrollController = scrollController;
    user = AuthCache.instance.getUser();
  }

  void onStationTap() async {
    Navigator.pushNamed(context!, MyPointsPage.routeName);
  }

  void onHistoryTap() async {
    Navigator.pushNamed(context!, RailHomeBookingPage.routeName);
  }

  void onHelpTap() async {
    Navigator.pushNamed(context!, RailBookingDetailPage.routeName);
  }

  Transaction? get lastHistory => histories.isEmpty ? null : histories.last;

  void fetchHistories(int page, int perPage, String orderBy, String sortBy, String trxStatus, String payStatus, String productType) async {
    if (!isLoaded) {
      histories = await BookingServices.getKAITransactionHistories(page, perPage, orderBy, sortBy, trxStatus, payStatus, productType);
      isLoaded = true;
      notifyListeners();
    }
  }

  onDigitalGoodsTap() {
    Navigator.pushNamed(context!, EGoodsHomeBookingPage.routeName);
  }

  onTourismHistoryTap() {
    Navigator.pushNamed(context!, TourismHomeBookingPage.routeName);
  }

  onSpecialHistoryTap() {
    Navigator.pushNamed(context!, SpecialHomeBookingPage.routeName);
  }

  onFlightHistoryTap() {
    Navigator.pushNamed(context!, FlightHomeBookingPage.routeName);
  }

  void showSnackBar(BuildContext context, String text, Color color, Color dismissColor) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 20,
        right: 20,
      ),
      content: Text(text),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: dismissColor,
        onPressed: () {
          //Do whatever you want
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> logout() async {
    var json = await UserService.logout();

    if (json["success"] == true) {
      showSnackBar(context!, json["message"], Colors.red, Colors.white);
      Navigator.pushNamedAndRemoveUntil(context!, LoginPage.routeName, (Route<dynamic> route) => false);
      return true;
    } else {
      return false;
    }
  }
}
