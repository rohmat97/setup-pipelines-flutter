import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

class SelectSeatArguments{
  final RailSchedule schedule;
  final RailBookingCart bookingCart;
  final String bookingCode;
  final int transactionId;
  final RailBookingInfo bookingInfo;

  SelectSeatArguments(this.schedule, this.bookingCart, this.bookingCode, this.transactionId, this.bookingInfo);
}