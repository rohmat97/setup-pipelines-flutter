import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/arguments/brand_arguments.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';

import '../models/brand.dart';
import '../../commons/models/transaction.dart';

class GoodsHomeState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  List<Transaction> histories = [];
  bool _disposed = false;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey) {
    context = ctx;
    key = scaffoldKey;
  }

  void getTransactionHistories() async {
    histories = await EGoodsServies.getTransactionHistories();
    notifyListeners();
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