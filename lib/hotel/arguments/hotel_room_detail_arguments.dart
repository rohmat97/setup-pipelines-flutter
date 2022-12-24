import '../models/hotel.dart';
import '../models/room.dart';

class HotelRoomDetailArguments {
  final Hotel hotel;
  final Room room;
  final DateTime dateIn;
  final DateTime dateOut;

  HotelRoomDetailArguments(this.hotel, this.room, this.dateIn, this.dateOut);
}