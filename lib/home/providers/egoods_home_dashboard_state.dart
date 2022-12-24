import 'package:flutter/material.dart';
import 'package:kai_wisata/home/models/history_payment.dart';
import 'package:kai_wisata/home/pages/egoods_booking_detail_page.dart';
import 'package:kai_wisata/home/pages/rail_booking_detail_page.dart';
import 'package:kai_wisata/home/providers/rail_home_dashboard_state.dart';
import 'package:kai_wisata/home/services/booking_service.dart';
import 'package:kai_wisata/pages/my_points_page.dart';

import '../../commons/models/transaction.dart';
import '../arguments/transaction_arguments.dart';

class EGoodsHomeDashboardState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  ScrollController? scrollController;

  List<Transaction> histories = [];
  List<Transaction> filtered = [];
  bool isLoaded = false;

  void init(
    BuildContext ctx, {
    GlobalKey<ScaffoldState>? scaffoldKey,
    ScrollController? scrollController,
  }) {
    context = ctx;
    key = scaffoldKey;
    this.scrollController = scrollController;
  }

  BookingStatus selectedCategoryId = BookingStatus.processed;
  void setSelectedCategoryId(BookingStatus value) {
    selectedCategoryId = value;
    filtered = histories.where((h) => h.status == value).toList();

    notifyListeners();
  }

  void onPointClicked() {
    Navigator.pushNamed(context!, MyPointsPage.routeName);
  }

  // List<BookingCategory> categoryList = [
  //   BookingCategory(id: BookingStatus.processed, title: 'Process'),
  //   BookingCategory(id: BookingStatus.completed, title: 'Completed'),
  //   BookingCategory(id: BookingStatus.canceled, title: 'Canceled'),
  // ];
  List<BookingCategory> categoryList = [
    BookingCategory(id: "NOT_PAID", title: 'Unpaid'),
    BookingCategory(id: "PAID", title: 'Process'),
    BookingCategory(id: "COMPLETED", title: 'Completed'),
    BookingCategory(id: "EXPIRED", title: 'Canceled'),
  ];

  void fetchHistories() async {
    if(!isLoaded) {
      histories = await BookingServices.getEGoodsTransactionHistories();
      filtered = histories.where((h) => h.status == BookingStatus.processed).toList();
      isLoaded = true;
      notifyListeners();
    }
  }

  onBackButton() {
    Navigator.pop(context!);
  }

  detailClick(Transaction p) {
    Navigator.pushNamed(
        context!,
        EGoodsBookingDetailPage.routeName,
        // arguments : TransactionArguments(p)
    );
  }
}
