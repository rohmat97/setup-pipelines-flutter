import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/order_data_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../arguments/input_passenger_arguments.dart';
import '../pages/03input_passenger_page.dart';
import 'base_state.dart';

class OrderDataState extends BaseState {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  OrderDataArguments? args;

  String title = "";
  String name = "";
  String phone = "";

  void initState(
      BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey,
      OrderDataArguments args
      ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;

    title = args.bookingCart.dataCallerCart.title;
    name = args.bookingCart.dataCallerCart.name;
    phone = args.bookingCart.dataCallerCart.phone;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  saveDataCaller(DataCallerCart dataCallerCart) async {
    args!.bookingCart.dataCallerCart = DataCallerCart(title, dataCallerCart.name, dataCallerCart.phone);
    var kontak = {
      "title": title,
      "name": dataCallerCart.name,
      "phone": dataCallerCart.phone,
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("caller", json.encode(kontak));
    var arg = InputPassengerArguments(args!.schedule, args!.bookingCart);

    Navigator.pushNamed(context!,
        InputPassengerPage.routeName,
        arguments: arg
    );
  }

  setTitle(String title) {
    this.title = title;
  }

  setName(String name) {
    this.name = name;
  }

  setPhone(String phone) {
    this.phone = phone;
  }
}
