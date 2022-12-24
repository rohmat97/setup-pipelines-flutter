import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

class DokuPaymentArguments {
  final RailSchedule schedule;
  final RailBookingCart booking;
  final String url;

  DokuPaymentArguments(this.schedule, this.booking, this.url);
}