import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

class OrderDataArguments {
  final RailSchedule schedule;
  final RailBookingCart bookingCart;

  OrderDataArguments(this.schedule, this.bookingCart);

}