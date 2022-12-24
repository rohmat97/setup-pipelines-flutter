import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

class SelectedPaymentArguments {
  final RailSchedule schedule;
  final RailBookingCart bookingCart;
  final String bookingCode;
  final int transactionId;

  SelectedPaymentArguments(this.schedule, this.bookingCart, this.bookingCode, this.transactionId);
}