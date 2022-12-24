import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/arguments/brand_arguments.dart';
import 'package:kai_wisata/digital_goods/services/egoods_services.dart';
import 'package:kai_wisata/hotel/services/hotel_services.dart';

import '../models/hotel.dart';
import '../arguments/search_hotel_arguments.dart';
import '../models/city.dart';
import '../pages/02hotel_list_page.dart';

class HotelSearchState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  DateTime? dateIn;
  DateTime? dateOut;
  City? city;
  List<City> cities = [];
  bool isLoaded = false;
  bool _disposed = false;

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey) {
    context = ctx;
    key = scaffoldKey;
  }

  void getCities() async {
    if(!isLoaded) {
      cities = await HotelServices.listCities("ID");
      isLoaded = true;
      notifyListeners();
    }
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
}