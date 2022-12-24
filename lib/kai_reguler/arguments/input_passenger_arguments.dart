import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

import '../models/rail_booking.dart';

class InputPassengerArguments {
  final RailSchedule schedule;
  final RailBookingCart bookingCart;

  InputPassengerArguments(this.schedule, this.bookingCart);
}