import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/flights/caches/schedule_cache.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';

class FlightScheduleState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  FlightResultModel? result;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
    result = ScheduleCache.instance.getSchedules();
  }

  void onBackButton() {
    Navigator.pop(context!);
  }
}