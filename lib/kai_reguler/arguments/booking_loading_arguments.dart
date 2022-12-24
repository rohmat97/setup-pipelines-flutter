import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

class BookingLoadingArguments{
  final RailSchedule schedule;
  final RailBookingCart bookingCart;
  // final PassengerCart passenger;

  BookingLoadingArguments(this.schedule, this.bookingCart);
}