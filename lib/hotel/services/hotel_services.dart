import 'package:flutter/material.dart';
import 'package:kai_wisata/hotel/models/hotel.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/hotel/models/hotel_booking_info.dart';

import '../../base_service.dart';
import '../models/city.dart';
import '../models/hotel_customer.dart';
import '../models/room.dart';

class HotelServices {

  static Future<List<City>> listCities(String countryId) async {
    String endPoint = "/hotel/listCityByCountry";
    Map<String, String> params = {
      "countryId": countryId,
    };
    var json = await BaseService.getWithParams(endPoint, params);
    return City.listFromJson(json["data"]);
  }

  static Future<List<Hotel>> listHotels(City city, DateTime dateIn, DateTime dateOut) async{
    String endPoint = "/hotel/searchAvailableHotel";
    Map<String, String> params = {
      "cityID": city.id,
      "checkInDate" : DateFormat("yyyy-MM-dd").format(dateIn),
      "checkOutDate" : DateFormat("yyyy-MM-dd").format(dateOut),
    };

    var json = await BaseService.getWithParams(endPoint, params);
    return Hotel.listFromJson(city, json["data"]);
  }

  static Future<List<Room>> listRooms(Hotel hotel, DateTime dateIn, DateTime dateOut) async{
    String endPoint = "/hotel/availableRooms";
    Map<String, String> params = {
      "cityID": hotel.city.id,
      "checkInDate" : DateFormat("yyyy-MM-dd").format(dateIn),
      "checkOutDate" : DateFormat("yyyy-MM-dd").format(dateOut),
      "hotelID" : hotel.id,
    };

    var json = await BaseService.getWithParams(endPoint, params);
    return Room.listFromJson(hotel, json["data"]["rooms"]);
  }

  static Future<String> book(HotelBookingInfo info) async{
    String endPoint = "/hotel/booking/";

    var json = await BaseService.post(endPoint, info.toMap());
    return json;
  }

}