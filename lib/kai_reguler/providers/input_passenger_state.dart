import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/data/cache/hive_repository.dart';
import 'package:kai_wisata/kai_reguler/arguments/input_passenger_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/order_data_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/selected_payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/passenger_data_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/pages/order_data_page.dart';
import 'package:kai_wisata/pages/order_details_page.dart';
import 'package:kai_wisata/kai_reguler/pages/passenger_data_page.dart';
import 'package:kai_wisata/kai_reguler/services/regular_ticket_service.dart';
import 'package:kai_wisata/pages/payment_page.dart';
import 'package:kai_wisata/kai_reguler/pages/05selected_payment_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../arguments/booking_loading_arguments.dart';
import '../pages/04booking_loading_page.dart';

class InputPassengerState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  InputPassengerArguments? args;
  // var passenger = {};
  // PassengerCart? get passenger => _passenger;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
    InputPassengerArguments args,
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  // set passenger(PassengerCart passengerCart) {
  //   _passenger = passengerCart;
  //   notifyListeners();
  // }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onOrderTap() async {
    await RailBookingCartRepository().put(
        RailBookingCartRepository.currentID, bookingInfo);
    Navigator.pushNamed(context!, OrderDataPage.routeName,
        arguments: OrderDataArguments(args!.schedule, bookingInfo)
    );
  }

  void onPassengerTap(PassengerCart passengerCart) async {
    Navigator.pushNamed(context!, PassengerDataPage.routeName,
        arguments: PassengerDataArguments(args!.schedule, args!.bookingCart, passengerCart)
    );
  }

  void onNext() async {
    Navigator.pushNamed(context!, BookingLoadingPage.routeName,
        arguments: BookingLoadingArguments(
            args!.schedule, args!.bookingCart));
  }

  String? get vendor => args!.schedule.vendor;
  String? get longDate => args!.schedule.longDate;
  String? get timeAndStationDesc => args!.schedule.timeAndStationDesc;
  String? get totalPassenger => "${args?.bookingCart.adults.length} Adult";

  RailBookingCart get bookingInfo => args!.bookingCart;

  Future<dynamic> bookCart() async {
    var gdsBookCode = await RegularTicketService.bookCart(bookingInfo);
    return gdsBookCode;
  }
}
