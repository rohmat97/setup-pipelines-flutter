import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/arguments/brand_arguments.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';

import '../models/brand.dart';

class BrandState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  BrandArguments? args;

  List<Brand> brands = [];
  String category = "";
  bool _disposed = false;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey,
      BrandArguments args,) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
    category = args.category;
  }

  void getBrandByCategory() async {
    brands = await EGoodsServies.listBrandsByCategory(category);
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