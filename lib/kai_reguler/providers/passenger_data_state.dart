import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/passenger_data_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import '../arguments/input_passenger_arguments.dart';
import '../pages/03input_passenger_page.dart';
import 'base_state.dart';

class PassengerDataState extends BaseState {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  PassengerDataArguments? args;

  int id = 0;
  String title = "";
  String src = "";
  String name = "";
  String ic = "";

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey, PassengerDataArguments args,
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;

    id = args.passenger.id;
    title = args.passenger.title;
    src = args.passenger.src;
    name = args.passenger.name;
    ic = args.passenger.identity;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  savePassenger(String name, String ic) async {
    var booking = args!.bookingCart;
    booking.adults[id-1] = PassengerCart(id, title, name, ic, src);
    var arg = InputPassengerArguments(args!.schedule, booking);

    Navigator.pushNamed(context!,
        InputPassengerPage.routeName,
        arguments: arg
    );
  }

  setTitle(String title) {
    this.title = title;
    //notifyListeners();
  }
  setName(String name) {
    this.name = name;
    notifyListeners();
  }
  setSource(String src) {
    this.src = src;
    //notifyListeners();
  }
  setIdentity(String identity) {
    ic = identity;
    notifyListeners();
  }
}
