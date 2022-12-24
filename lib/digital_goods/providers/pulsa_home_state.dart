import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/arguments/brand_arguments.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';

import '../arguments/pulsa_home_arguments.dart';
import '../models/brand.dart';
import '../models/product.dart';

class PulsaHomeState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  PulsaHomeArguments? args;

  List<Product> products = [];
  String brand = "";
  bool _disposed = false;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey,
      PulsaHomeArguments args,) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void getProductByBrand() async {
    products = await EGoodsServies.listProductByBrand(args!.brand);
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