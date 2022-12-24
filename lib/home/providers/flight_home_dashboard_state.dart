import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';
import 'package:kai_wisata/home/arguments/histories_arguments.dart';
import 'package:kai_wisata/home/models/histories/history_booking_model.dart';
import 'package:kai_wisata/home/models/history_payment.dart';
import 'package:kai_wisata/home/pages/flight_booking_detail_page.dart';
import 'package:kai_wisata/home/pages/rail_booking_detail_page.dart';
import 'package:kai_wisata/home/services/booking_service.dart';
import 'package:kai_wisata/pages/my_points_page.dart';
import 'package:kai_wisata/user/models/auth_cache.dart';
import 'package:kai_wisata/user/models/kai_user.dart';

import '../../commons/models/transaction.dart';
import '../arguments/transaction_arguments.dart';

class FlightHomeDashboardState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  ScrollController? scrollController;

  List<HistoryBookingModel> histories = [];
  List<HistoryBookingModel> filtered = [];
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

  String selectedCategoryId = "NOT_PAID";
  void setSelectedCategoryId(String value) {
    selectedCategoryId = value;
    filtered = histories.where((h) => h.paymentStatus == value).toList();

    notifyListeners();
  }

  void onPointClicked() {
    Navigator.pushNamed(context!, MyPointsPage.routeName);
  }

  List<BookingCategory> categoryList = [
    BookingCategory(id: "NOT_PAID", title: 'Unpaid'),
    BookingCategory(id: "processes", title: 'Process'),
    BookingCategory(id: "COMPLETED", title: 'Completed'),
    BookingCategory(id: "canceled", title: 'Canceled'),
  ];

  void fetchHistories(int page, int perPage, String orderBy, String sortBy, String trxStatus, String payStatus, String productType) async {
    if(!isLoaded) {
      histories = await BookingServices.getFlightTransactionHistories(page, perPage, orderBy, sortBy, trxStatus, payStatus, productType);
      filtered = histories.where((h) => h.paymentStatus == "NOT_PAID").toList();
      isLoaded = true;
      notifyListeners();
    }
  }

  onBackButton() {
    Navigator.pop(context!);
  }

  detailClick(HistoryBookingModel p) {
    Navigator.pushNamed(
        context!,
        FlightBookingDetailPage.routeName,
        arguments : HistoriesArguments(p)
    );
  }
}

class BookingCategory {
  BookingCategory({this.id, this.title, this.routeName});
  final String? id;
  final String? title;
  final String? routeName;
}
