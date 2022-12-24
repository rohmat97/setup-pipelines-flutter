import 'package:flutter/material.dart';
import 'package:kai_wisata/data/models/ticket_class.dart';
import 'package:kai_wisata/kai_reguler/arguments/search_ticket_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/caches/search_ticket_caches.dart';
import 'package:kai_wisata/kai_reguler/models/caches/station_caches.dart';
import 'package:kai_wisata/kai_reguler/pages/02search_result_page.dart';
import 'package:kai_wisata/kai_reguler/pages/station_page.dart';
import 'package:kai_wisata/kai_reguler/services/regular_ticket_service.dart';

import 'package:intl/intl.dart';

import '../../data/models/station.dart';
import 'base_state.dart';

class RegularTicketState extends BaseState {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  List<Station> fromStations = [];
  List<Station> toStations = [];

  Station? fromStation;
  Station? toStation;

  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();

  int seat = 1;

  TicketClass seatClass = TicketClass.economy;

  int adultTicketCount = 1;
  int childTicketCount = 0;
  int infantTicketCount = 0;

  bool isRoundTrip = false;

  List<SearchTicketArguments> histories = [];

  bool isLoaded = false;
  var isValid = false;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void setSeat(int theSeat) {
    seat = theSeat;
    adultTicketCount = theSeat;

    notifyListeners();
  }

  void setFromStation(Station station) {
    fromStation = station;
    isValid = fromStation != null && toStation != null;
    if (toStation != null) {
      isValid = fromStation != toStation && isValid;
    }

    notifyListeners();
  }

  void setToStation(Station station) {
    toStation = station;
    isValid = fromStation != null && toStation != null;
    isValid = fromStation != toStation && isValid;

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
    notifyListeners();
  }

  bool isTicketFlexible = false;
  void setTicketFlexible(bool value) {
    isTicketFlexible = value;
    notifyListeners();
  }

  Future<bool> fetchStations() async {
    if (!isLoaded) {
      var response = await RegularTicketService.fetchStations();
      if (response.message == "") {
        fromStations = response.origins;
        toStations = response.destinations;

        // cache stations
        StationCaches.instance.save(fromStations);
        histories = await SearchTicketCaches.instance.getBookings();
        histories.reversed;
        histories = histories.toList();
        isLoaded = true;

        notifyListeners();
      }
    }

    return true;
  }

  void onSearchButton() {
    Navigator.pushNamed(context!, SearchResultPage.routeName,
        arguments: getSearchTicketArguments());
  }

  void onStationTap() async {
    Navigator.pushNamed(context!, StationPage.routeName);
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

  void setSeatClass(TicketClass kelass) {
    seatClass = kelass;
    notifyListeners();
  }

  void fetchHistories() async {
    histories = await SearchTicketCaches.instance.getBookings();
    histories.reversed;
    histories = histories.toList();
    notifyListeners();
  }

  SearchTicketArguments getSearchTicketArguments() {
    return SearchTicketArguments(
        fromStation,
        toStation,
        fromDate,
        toDate,
        isRoundTrip,
        seat,
        adultTicketCount,
        childTicketCount,
        infantTicketCount,
        seatClass);
  }

  String getToDate() {
    return toDate != null ? DateFormat("dd MMM yyyy").format(toDate!) : "";
  }

  String getFromDate() {
    return fromDate != null ? DateFormat("dd MMM yyyy").format(fromDate!) : "";
  }

  String getFromStation() {
    return fromStation != null ? fromStation!.toString() : "Pilih";
  }

  String getToStation() {
    return toStation != null ? toStation!.toString() : "Pilih";
  }

  onSearch(SearchTicketArguments arg) {
    Navigator.pushNamed(context!, SearchResultPage.routeName, arguments: arg);
  }

  List<dynamic> checkError() {
    isValid = true;
    final now = new DateTime.now();
    final date = new DateTime(now.year, now.month, now.day);

    if (fromStation == null) {
      isValid = false;
    }
    if (fromStation != null) {
      if (toStation == null) {
        isValid = false;
      }
    }
    if (fromStation != null) {
      if (fromStation == toStation) {
        isValid = false;
      }
    }

    if (fromDate!.isBefore(date)) {
      isValid = false;
    }

    if (isRoundTrip) {
      if (fromDate!.isAfter(toDate!)) {
        isValid = false;
      }
    }

    if (isValid) {
      return [false, ""];
    } else {
      List<String> message = [];
      if (fromStation == null) {
        message.add("Stasiun Asal harus di isi");
      }
      if (fromStation != null) {
        if (toStation == null) {
          message.add("Stasiun Tujuan harus di isi");
        }
      }
      if (fromStation != null) {
        if (fromStation == toStation) {
          message.add("Stasiun Tujuan tidak boleh sama dengan Stasiun Asal");
        }
      }
      if (fromDate!.isBefore(date)) {
        message
            .add("Tanggal Pergi tidak bisa dipilih sebelum tanggal hari ini");
      }

      if (isRoundTrip) {
        if (fromDate!.isAfter(toDate!)) {
          message
              .add("Tanggal Pulang tidak bisa dipilih sebelum Tanggal Pergi");
        }
      }

      return [true, message.join("\n")];
    }
  }
}
