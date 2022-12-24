import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/input_passenger_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/search_ticket_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';
import 'package:kai_wisata/kai_reguler/pages/03input_passenger_page.dart';
import 'package:kai_wisata/kai_reguler/providers/base_state.dart';
import 'package:kai_wisata/kai_reguler/services/regular_ticket_service.dart';
import 'package:kai_wisata/pages/round_trip_page.dart';

import 'package:intl/intl.dart';

import '../models/caches/search_ticket_caches.dart';

enum SortResult {
  cheapest,
  earliest,
  latest
}

class SearchResultState extends BaseState {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  List<RailSchedule> schedules = [];
  SearchTicketArguments args = SearchTicketArguments.empty();
  bool isLoaded = false;
  SortResult sort = SortResult.cheapest;

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

  void onTicketSelected(RailSchedule schedule) {
    var args = InputPassengerArguments(schedule,
        RailBookingCart.fromScheduleAndPassengers(schedule, this.args.adult, this.args.child));

    Navigator.pushNamed(context!,
        InputPassengerPage.routeName,
        arguments: args
    );
    //Navigator.pushNamed(context!, RoundTripPage.routeName);
  }

  void changeSort(SortResult sort){
    this.sort = sort;
    switch(sort) {
      case SortResult.cheapest :
        schedules.sort((a, b) => a.adultDiscount.compareTo(b.adultDiscount));
        break;
      case SortResult.earliest :
        schedules.sort((a, b) => a.departureTime.compareTo(b.departureTime));
        break;
      case SortResult.latest :
        schedules.sort((b, a) => a.departureTime.compareTo(b.departureTime));
        break;
    }

    notifyListeners();

    Navigator.pop(context!);
  }

  void searchTicketOnce(SearchTicketArguments args) {
    this.args = args;

    if(isLoaded) {
      return;
    }

    // save on search ticket histories
    SearchTicketCaches.instance.add(args);

    RegularTicketService.getRailSchedule(args).then((value){
      schedules = value;

      //default is sort by cheapest
      schedules.sort((a, b) => a.adultDiscount.compareTo(b.adultDiscount));
      isLoaded = true;

      notifyListeners();
    });
  }

  String getHeaderTitle() {
    return "${args.from?.name} - ${args.to?.name}";
  }

  String getHeaderDescription() {
    return "${DateFormat("dd MMM yyyy").format(args.fromDate!)} - ${args.adult} Penumpang";
  }
}
