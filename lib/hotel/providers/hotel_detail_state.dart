import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/arguments/brand_arguments.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';
import 'package:kai_wisata/hotel/arguments/hotel_room_detail_arguments.dart';
import 'package:kai_wisata/hotel/models/room.dart';
import 'package:kai_wisata/hotel/pages/04hotel_room_detail_page.dart';
import 'package:kai_wisata/hotel/services/hotel_services.dart';

import '../arguments/hotel_detail_arguments.dart';
import '../models/hotel.dart';
import '../arguments/search_hotel_arguments.dart';
import '../models/city.dart';

class HotelDetailState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  DateTime? dateIn;
  DateTime? dateOut;
  City? city;
  List<Room> rooms = [];

  bool loaded = false;
  bool _disposed = false;

  HotelDetailArguments? args;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey, HotelDetailArguments args) {
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
}