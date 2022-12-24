import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/input_passenger_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/search_ticket_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';
import 'package:kai_wisata/kai_reguler/pages/03input_passenger_page.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_schedule.dart';
import 'package:kai_wisata/kai_wisata/pages/03tourism_wagon_page.dart';
import 'package:kai_wisata/kai_wisata/services/wisata_services.dart';

import '../arguments/tourism_search_arguments.dart';
import '../arguments/tourism_wagon_arguments.dart';

enum SortResult { cheapest, earliest, latest }

class TourismResultState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  List<TourismSchedule> schedules = [];
  TourismSearchArguments args = TourismSearchArguments.empty();
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

  void searchTicketOnce(TourismSearchArguments args) {
    this.args = args;

    if(isLoaded) {
      return;
    }
    WisataService.getRailSchedule(args).then((value){
      schedules = value;

      //default is sort by cheapest
      schedules.sort((a, b) => a.departureTime.compareTo(b.departureTime));
      isLoaded = true;

      notifyListeners();
    });
  }

  void onTicketSelected(TourismSchedule schedule) {
    Navigator.pushNamed(
        context!,
        TourismWagonPage.routeName,
        arguments : TourismWagonArguments(args, schedule)
    );
  }

  void changeSort(SortResult sort) {
    this.sort = sort;
    switch (sort) {
      case SortResult.cheapest:
        schedules.sort((a, b) => a.departureTime.compareTo(b.departureTime));
        break;
      case SortResult.earliest:
        schedules.sort((a, b) => a.departureTime.compareTo(b.departureTime));
        break;
      case SortResult.latest:
        schedules.sort((b, a) => a.departureTime.compareTo(b.departureTime));
        break;
    }

    notifyListeners();

    Navigator.pop(context!);
  }

  String getHeaderTitle() {
    return "${args.from?.name} - ${args.to?.name}";
  }

  String getHeaderDescription() {
    return "${DateFormat("dd MMM yyyy").format(args.fromDate!)}";
  }

  void onTapped() {
    Navigator.pushNamed(context!, TourismWagonPage.routeName);
  }
}
