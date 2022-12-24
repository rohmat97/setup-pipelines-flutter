import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';

class FlightBookingDetailState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  bool _disposed = false;

  List<AirportsModel> airports = [];
  
  bool isLoaded = false;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onBackButton() {
    Navigator.pop(context!);
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

  void getAllAirports() async {
    if (!isLoaded) {
      airports = await FlightService.getAllAirports();
      isLoaded = true;
      notifyListeners();
    }
  }

  String searchAirportName(String code) {
    return airports.where((ap) => ap.airportCode == code).toString();
  }

}
