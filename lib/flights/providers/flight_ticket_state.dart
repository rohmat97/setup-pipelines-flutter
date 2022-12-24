import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/data/models/airport.dart';
import 'package:kai_wisata/flights/arguments/flight_result_arguments.dart';
import 'package:kai_wisata/flights/caches/airport_cache.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';
import 'package:kai_wisata/flights/pages/flight_result_page.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

import '../../data/models/airport.dart';

class FlightTicketState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  AirportsModel? fromAirport;
  AirportsModel? toAirport;

  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();

  int seat = 1;
  int seatChild = 0;
  int seatInfant = 0;

  int adultTicketCount = 1;
  int childTicketCount = 0;
  int infantTicketCount = 0;

  bool isRoundTrip = false;

  bool isLoaded = false;
  var isValid = false;

  String tripType = "OneWay";
  String fromAirportCity = "";
  String toAirportCity = "";
  String accCode = '';

  FlightResultModel? _result;

  FlightResultModel? get result => _result;

  set result(FlightResultModel? result) {
    _result = result;
    notifyListeners();
  }

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void setFromAirport(AirportsModel airport) {
    fromAirport = airport;
    isValid = fromAirport != null && toAirport != null;

    notifyListeners();
  }

  void setToAirport(AirportsModel airport) {
    toAirport = airport;
    isValid = fromAirport != null && toAirport != null;

    notifyListeners();
  }

  void setSeat(int theSeat){
    seat = theSeat;
    adultTicketCount = theSeat;

    notifyListeners();
  }

  void setSeatChild(int theSeat){
    seatChild = theSeat;
    childTicketCount = theSeat;

    notifyListeners();
  }

  void setSeatInfant(int theSeat){
    seatInfant = theSeat;
    infantTicketCount = theSeat;

    notifyListeners();
  }

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  void setRoundTrip(bool value) {
    isRoundTrip = value;

    if (isRoundTrip == true) {
      tripType = 'RoundTrip';
    } else {
      tripType = 'OneWay';
    }

    notifyListeners();
  }

  void setAccCode(String code){
    accCode = code;

    notifyListeners();
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void setAdultTicketCount(int count) {
    adultTicketCount = count;
    notifyListeners();
  }

  void setChildTicketCount(int count) {
    childTicketCount = count;
    notifyListeners();
  }

  void setInfantTicketCount(int count) {
    infantTicketCount = count;
    notifyListeners();
  }

  String getToDate() {
    return toDate != null ? DateFormat("dd MMM yyyy").format(toDate!) : "";
  }

  String getFromDate() {
    return fromDate != null ? DateFormat("dd MMM yyyy").format(fromDate!) : "";
  }

  String getFromAirport() {
    final cage = fromAirport!.airportCity!.contains(RegExp(r'[()]'));

    if (cage) {
      fromAirportCity = fromAirport!.airportCity.toString();
    } else {
      fromAirportCity = "${fromAirport!.airportCity} (${fromAirport!.airportCode})";
    }
    return fromAirport != null ? fromAirportCity : "Pilih";
  }

  String getToAirport() {
    final cage = toAirport!.airportCity!.contains(RegExp(r'[()]'));

    if (cage) {
      toAirportCity = toAirport!.airportCity.toString();
    } else {
      toAirportCity = "${toAirport!.airportCity} (${toAirport!.airportCode})";
    }
    return toAirport != null ? toAirportCity : "Pilih";
  }

  Map<String, dynamic> getDataAirport() {
    if (isRoundTrip == true) {
      tripType = 'RoundTrip';
    } else {
      tripType = 'OneWay';
    }
    Map<String, dynamic> reqAirport = {
      "trip_type": tripType,
      "org": fromAirport!.airportCode,
      "des": toAirport!.airportCode,
      "departure_date": DateFormat("yyyy-MM-dd").format(fromDate!),
      "return_date": DateFormat("yyyy-MM-dd").format(toDate!),
      // "return_date": DateFormat("yyyy-MM-dd").format(toDate!) == DateFormat("yyyy-MM-dd").format(DateTime.now()) ? "" : DateFormat("yyyy-MM-dd").format(toDate!),
      "pax_adult": seat,
      "pax_chile": seatChild,
      "pax_infant": seatInfant,
      "page": 1,
      "per_page": 10,
      "sort_by": "id",
      "order": "asc",
    };

    return reqAirport;
  }

  Future<FlightResultModel> getScheduleAll(String accCode) async {
    // try {
    //   FlightResultModel result = await FlightService().getScheduleAll(fromAirport: fromAirport!.airportCode, toAirport: toAirport!.airportCode, dateFrom: fromDate, dateTo: toDate, adult: seat, child: seatChild, infant: seatInfant, tripType: tripType);
    //   // ScheduleCache.instance.saveSchedules(result);
    //   _result = result;

    //   return result;
    // } catch (e) {
    //   // print(e);
    //   return result;
    // }
    FlightResultModel result = await FlightService().getScheduleAll(fromAirport: fromAirport!.airportCode, toAirport: toAirport!.airportCode, dateFrom: fromDate, dateTo: toDate, adult: seat, child: seatChild, infant: seatInfant, tripType: tripType, accCode: accCode);
    _result = result;

    return result;
  }

  Future<bool> onNextButton(String accCode,) async {
    FlightResultModel sch = await getScheduleAll(accCode);
    // print(sch.image);
    // return true;
    if (sch.success! == true) {
      await Navigator.pushNamed(context!, FlightResultPage.routeName, arguments: flightResultArguments());
      return true;
    } else {
      if (sch.message != "Data Schedule gagal didapatkan, masukan kode sesuai gambar!") {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(content: Text("Jadwal penerbangan untuk rute ini tidak ada!")));
      } else {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(content: Text("Mohon maaf, cobalah beberapa saat lagi!")));
      }
      // print(sch.success);
      return false;
    }
  }

  void onNextButtonWithoutData() {
    Navigator.pushNamed(context!, FlightResultPage.routeName);
  }

  FlightResultArguments flightResultArguments() {
    if (isRoundTrip == true) {
      tripType = 'RoundTrip';
    } else {
      tripType = 'OneWay';
    }
    return FlightResultArguments(fromAirport!.airportCode, toAirport!.airportCode, fromDate, toDate, isRoundTrip, seat, seatChild, seatInfant, tripType, result);
  }
}