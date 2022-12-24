import '../models/hotel.dart';

class HotelDetailArguments {
  final Hotel hotel;
  final DateTime dateIn;
  final DateTime dateOut;

  HotelDetailArguments(this.hotel, this.dateIn, this.dateOut);
}

