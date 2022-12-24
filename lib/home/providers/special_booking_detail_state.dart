import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/home/services/booking_service.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';

class SpecialBookingDetailState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  bool _disposed = false;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

}
