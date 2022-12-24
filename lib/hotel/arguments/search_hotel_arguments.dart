import '../models/city.dart';

class HotelSearchArguments {
  final City city;
  final DateTime dateIn;
  final DateTime dateOut;

  HotelSearchArguments(this.city, this.dateIn, this.dateOut);
}