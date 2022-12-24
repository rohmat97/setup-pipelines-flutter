import 'package:kai_wisata/kai_wisata/arguments/tourism_search_arguments.dart';

import '../models/tourism_schedule.dart';
import '../models/tourism_tipe.dart';

class TourismDetailArguments {
  final TourismSearchArguments searchArguments;
  final TourismSchedule schedule;
  final TourismTipe wagon;

  TourismDetailArguments(this.searchArguments, this.schedule, this.wagon);
}