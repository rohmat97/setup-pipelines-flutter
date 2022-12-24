import 'package:kai_wisata/kai_wisata/arguments/tourism_search_arguments.dart';

import '../models/tourism_customer.dart';
import '../models/tourism_schedule.dart';
import '../models/tourism_tipe.dart';

class TourismCustomerArguments {
  final TourismSearchArguments searchArguments;
  final TourismSchedule schedule;
  final TourismTipe wagon;
  final TourismCustomer customer;

  TourismCustomerArguments(this.searchArguments, this.schedule, this.wagon, this.customer);
}