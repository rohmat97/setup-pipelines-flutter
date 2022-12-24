import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

class PassengerDataArguments {
  final RailSchedule schedule;
  final RailBookingCart bookingCart;
  final PassengerCart passenger;

  PassengerDataArguments(this.schedule, this.bookingCart, this.passenger);

}