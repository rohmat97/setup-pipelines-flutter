import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/arguments/brand_arguments.dart';
import 'package:kai_wisata/digital_goods/arguments/pulsa_confirmation_arguments.dart';
import 'package:kai_wisata/digital_goods/models/buy_info.dart';
import 'package:kai_wisata/digital_goods/pages/04order_loading_page.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';

import '../arguments/goods_order_loading_arguments.dart';
import '../models/brand.dart';

class PulsaConfirmationState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  PulsaConfirmationArguments? args;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey,
      PulsaConfirmationArguments args,) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void confirm() async {
    Navigator.pushNamed(context!,
        GoodsOrderLoadingPage.routeName,
        arguments: GoodsOrderLoadingArguments(
          args!.brand,
          BuyInfo(args!.product.code, args!.nomer, args!.product.price)
        )
    );

  }

}