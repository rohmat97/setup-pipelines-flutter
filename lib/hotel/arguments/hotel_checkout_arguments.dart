import 'package:kai_wisata/hotel/models/hotel_customer.dart';

import '../models/hotel.dart';
import '../models/room.dart';

class HotelCheckoutArguments {
  final HotelCustomer customer;
  final Hotel hotel;
  final Room room;
  final DateTime dateIn;
  final DateTime dateOut;

  HotelCheckoutArguments(this.customer, this.hotel, this.room, this.dateIn, this.dateOut);
}