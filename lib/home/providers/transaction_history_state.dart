import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/models/transaction.dart';

import '../models/history_payment.dart';
import '../services/booking_service.dart';

class TransactionHistoryState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  List<Transaction> histories = [];
  bool isLoaded = false;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void fetchHistories(int page, int perPage, String orderBy, String sortBy, String trxStatus, String payStatus, String productType) async {
    if(!isLoaded) {
      histories = await BookingServices.getKAITransactionHistories(page, perPage, orderBy, sortBy, trxStatus, payStatus, productType);
      isLoaded = true;
      notifyListeners();
    }
  }

  void onBackButton() {
    Navigator.pop(context!);
  }
}
