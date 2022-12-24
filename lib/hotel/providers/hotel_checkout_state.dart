import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/hotel/arguments/hotel_order_loading_arguments.dart';
import 'package:kai_wisata/hotel/arguments/hotel_room_detail_arguments.dart';
import 'package:kai_wisata/hotel/models/hotel_booking_info.dart';
import 'package:kai_wisata/hotel/models/hotel_customer.dart';
import 'package:kai_wisata/hotel/models/room.dart';
import 'package:kai_wisata/hotel/pages/04hotel_room_detail_page.dart';
import 'package:kai_wisata/hotel/pages/07hotel_order_loading_page.dart';
import 'package:kai_wisata/hotel/services/hotel_services.dart';

import '../arguments/hotel_checkout_arguments.dart';
import '../arguments/hotel_detail_arguments.dart';
import '../models/city.dart';

class HotelCheckoutState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  DateTime? dateIn;
  DateTime? dateOut;
  City? city;
  List<Room> rooms = [];

  bool loaded = false;
  bool _disposed = false;

  HotelCheckoutArguments? args;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey, HotelCheckoutArguments args) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
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

  void onPaymentClick() {
    var customer = HotelCustomer("Mr.", "Datu", "Rajab", "+62817342564", "datu@gmail.com");
    var info = HotelBookingInfo(customer, args!.hotel, args!.room, args!.dateIn, args!.dateOut);
    Navigator.pushNamed(
        context!,
        HotelOrderLoadingPage.routeName,
        arguments: HotelOrderLoadingArguments(info)
    );
  }
}