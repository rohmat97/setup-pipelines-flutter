import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';

class PaymentArguments {
  final RailBooking booking;
  final String gdsBookCode;

  PaymentArguments(this.booking, this.gdsBookCode);
}