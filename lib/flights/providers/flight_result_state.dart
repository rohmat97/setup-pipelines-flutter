import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/arguments/flight_detail_arguments.dart';
import 'package:kai_wisata/flights/arguments/flight_result_arguments.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/flights/caches/schedule_cache.dart';
import 'package:kai_wisata/flights/models/flight_detail_model.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';
import 'package:kai_wisata/flights/pages/flight_detail_page.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';

enum SortResult {
  cheapest,
  earliest,
  latest
}

class FlightResultState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  FlightResultArguments? args;

  String? from;
  String? to;
  DateTime? fromDate;
  DateTime? toDate;

  int? adult;
  int? child;
  int? infant;

  bool isRoundTrip = false;

  String tripType = "OneWay";
  String accCode = '';

  Map<String, dynamic> reqBodySchedule = {};

  String? idSchDepart;
  String? idSchReturn;

  bool isLoaded = false;
  SortResult sort = SortResult.cheapest;

  FlightDetailModel? _detail;

  FlightDetailModel? get detail => _detail;

  set detail(FlightDetailModel? detail) {
    _detail = detail;
    notifyListeners();
  }

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
    FlightResultArguments args,
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void setFromAirport(String fromAirport) {
    from = fromAirport;
    notifyListeners();
  }

  void setToAirport(String toAirport) {
    to = toAirport;
    notifyListeners();
  }

  void setDateFrom(DateTime dateFrom) {
    fromDate = dateFrom;
    notifyListeners();
  }

  void setDateTo(DateTime dateTo) {
    toDate = dateTo;
    notifyListeners();
  }

  void setSeat(int theSeat){
    adult = theSeat;

    notifyListeners();
  }

  void setSeatChild(int theSeat){
    child = theSeat;

    notifyListeners();
  }

  void setSeatInfant(int theSeat){
    infant = theSeat;

    notifyListeners();
  }

  void setIdSchDepart(String idDepart){
    idSchDepart = idDepart;

    notifyListeners();
  }

  void setIdSchReturn(String idReturn){
    idSchReturn = idReturn;

    notifyListeners();
  }

  void setReqBodySchedule(
    String fromAirport,
    String toAirport,
    DateTime dateFrom,
    DateTime dateTo,
    int adult,
    int child,
    int infant,
    String tripType,
  ) {
    reqBodySchedule.addAll({
      "trip_type": tripType,
      "org": fromAirport,
      "des": toAirport,
      "departure_date": DateFormat("yyyy-MM-dd").format(dateFrom),
      "return_date": DateFormat("yyyy-MM-dd").format(dateTo),
      "pax_adult": adult,
      "pax_chile": child,
      "pax_infant": infant,
      "page": 1,
      "per_page": 10,
      "sort_by": "id",
      "order": "asc",
    });
    notifyListeners();
  }

  void changeSort(SortResult sort){
    this.sort = sort;
    switch(sort) {
      case SortResult.cheapest :
        // detail!.departure!.sort((a, b) => a.adultDiscount.compareTo(b.adultDiscount));
        break;
      case SortResult.earliest :
        // detail!.departure!.sort((a, b) => a.departureTime.compareTo(b.departureTime));
        break;
      case SortResult.latest :
        // detail!.departure!.sort((b, a) => a.departureTime.compareTo(b.departureTime));
        break;
    }

    notifyListeners();

    Navigator.pop(context!);
  }

  String getHeaderTitle() {
    return "${from} - ${to}";
  }

  String getHeaderDescription() {
    // ignore: unnecessary_string_interpolations
    return "${DateFormat("dd MMM yyyy").format(fromDate!)}";
  }

  // String getSeatAdult() {
  //   return "$adult";
  // }

  Future<FlightDetailModel> getScheduleDetail(String? idscdep, String? idscret, String? accCode) async {
    // try {
    //   FlightDetailModel detail = await FlightService().getScheduleDetail(idScheduleDepart: idscdep, idScheduleReturn: idscret);

    //   _detail = detail;
    //   // print(tripType);

    //   return true;
    // } catch (e) {
    //   print(e);
    //   return false;
    // }
    FlightDetailModel detail = await FlightService().getScheduleDetail(idScheduleDepart: idscdep, idScheduleReturn: idscret, accCode: accCode);

    _detail = detail;

    return detail;
  }

  Future<bool> onNextButton(BuildContext context, String accCode,) async {
    FlightDetailModel detail = await getScheduleDetail(idSchDepart, idSchReturn, accCode);
    // print("On Next Button From Argument State: ${detail.toJson()}");

    if (detail.success == true) {
      await Navigator.pushNamed(context, FlightDetailPage.routeName, arguments: flightDetailArguments());

      return true;
    } else {
      if (detail.message == 'Invalid argument supplied for foreach()') {
        ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Mohon maaf, saat ini penerbangan tidak boleh beda maskapai!")));
      }
      return false;
    }
  }

  FlightDetailArguments flightDetailArguments() {
    if (isRoundTrip == true) {
      tripType = 'RoundTrip';
    } else {
      tripType = 'OneWay';
    }
    // print("Trip Type From Argument State: ${detail?.toJson()}");
    return FlightDetailArguments(args?.from, args?.to, args?.fromDate, args?.toDate, args?.isReturn, args?.adult, args?.child, args?.infant, args?.tripType, detail, idSchDepart, idSchReturn);
  }

  void onBackButton() {
    Navigator.pop(context!);
  }
}