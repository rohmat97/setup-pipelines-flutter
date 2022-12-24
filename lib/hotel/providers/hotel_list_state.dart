import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/arguments/brand_arguments.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';
import 'package:kai_wisata/hotel/arguments/hotel_detail_arguments.dart';
import 'package:kai_wisata/hotel/pages/03hotel_detail_page.dart';
import 'package:kai_wisata/hotel/services/hotel_services.dart';

import '../models/hotel.dart';
import '../arguments/search_hotel_arguments.dart';
import '../models/city.dart';
import '../pages/02hotel_list_page.dart';

class HotelListState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  DateTime? dateIn;
  DateTime? dateOut;
  City? city;
  List<Hotel> hotels = [];

  bool _disposed = false;

  HotelSearchArguments? args;

  bool isLoading = false;
  bool isLoaded = false;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey,
      HotelSearchArguments args
      ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void getHotels() async {
    if(isLoaded){
      return;
    }

    isLoading = true;
    hotels = await HotelServices.listHotels(args!.city, args!.dateIn, args!.dateOut);
    isLoading = false;
    isLoaded = true;
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

  void onSearchClick() {
    if(city != null) {
      Navigator.pushNamed(
          context!,
          HotelListPage.routeName,
          arguments: HotelSearchArguments(city!, dateIn!, dateOut!)
      );
    }
  }

  void onDetailClick(Hotel hotel) {
    Navigator.pushNamed(
        context!,
        HotelDetailPage.routeName,
        arguments: HotelDetailArguments(hotel, args!.dateIn, args!.dateOut)
    );
  }
}