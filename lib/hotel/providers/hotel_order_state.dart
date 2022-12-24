import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/hotel/arguments/hotel_room_detail_arguments.dart';
import 'package:kai_wisata/hotel/models/hotel_customer.dart';
import 'package:kai_wisata/hotel/models/room.dart';
import 'package:kai_wisata/hotel/pages/04hotel_room_detail_page.dart';
import 'package:kai_wisata/hotel/services/hotel_services.dart';

import '../arguments/hotel_checkout_arguments.dart';
import '../arguments/hotel_detail_arguments.dart';
import '../models/city.dart';
import '../pages/06hotel_checkout_page.dart';

class HotelOrderState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  DateTime? dateIn;
  DateTime? dateOut;
  City? city;
  List<Room> rooms = [];

  bool loaded = false;
  bool _disposed = false;

  HotelRoomDetailArguments? args;

  String title = "";

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey, HotelRoomDetailArguments args) {
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

  void getRooms() async {
    if(!loaded) {
      rooms =
      await HotelServices.listRooms(args!.hotel, args!.dateIn, args!.dateOut);
      loaded = true;
      notifyListeners();
    }
  }

  void onRoomClick(Room room) {
    Navigator.pushNamed(
        context!,
        HotelRoomDetailPage.routeName,
        arguments: HotelRoomDetailArguments(args!.hotel, room, args!.dateIn, args!.dateOut)
    );
  }

  void onCheckOutClick(HotelCustomer cust) {
    Navigator.pushNamed(
        context!,
        HotelCheckoutPage.routeName,
        arguments: HotelCheckoutArguments(cust, args!.hotel, args!.room, args!.dateIn, args!.dateOut)
    );
  }

  setTitle(String title) {
    this.title = title;
    notifyListeners();
  }
}