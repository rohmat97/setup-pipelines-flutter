import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:kai_wisata/digital_goods/models/postpaid_listrik.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';
import 'package:kai_wisata/digital_goods/pages/digital_goods_select_payment_method_page.dart';
import 'package:kai_wisata/digital_goods/arguments/digital_goods_selected_payment_arguments.dart';

class ListrikHomeState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  PostpaidListrik? tagihan;

  bool isLoaded = false;

  int? amountToCharge;
  int? adm;
  int? tagihanListrik;
  String? nama;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  Future<bool> fetchTagihan(nomorMeter) async {
    if (!isLoaded) {
      tagihan = await EGoodsServies.fetchTagihan(nomorMeter);
      print(tagihan?.amountToCharge);
      amountToCharge = tagihan?.amountToCharge;
      // parse SN
      var sns = tagihan?.sn.split('/');

      // print(sns);
      if (sns != null) {
        for (var sn in sns) {
          print(sn);
          var r = sn.split(':');
          if (r[0] == 'NAMA') {
            nama = r[1];
          }
          if (r[0] == 'ADM') {
            adm = int.tryParse(r[1]);
          }

          if (r[0] == 'TAGIHAN') {
            tagihanListrik = int.tryParse(r[1]);
          }
        }
      }

      isLoaded = true;

      notifyListeners();
    }
    return true;
  }

  Future<void> nextStep(String nomor_meter) async {
    // create transaction
    var transaction = await EGoodsServies.setTransaction(
        tagihan!, "PLN PASCABAYAR", nomor_meter);

    Navigator.pushNamed(context!, DigitalGoodsSelectPaymentMethodPage.routeName,
        arguments: DigitalGoodsSelectedPaymentArguments(transaction, tagihan!,
            transaction.id, nama!, adm!, tagihanListrik!));
  }
}
