import 'package:kai_wisata/hotel/models/room.dart';
import 'package:intl/intl.dart';

import 'hotel.dart';
import 'hotel_customer.dart';

class HotelBookingInfo {
  final HotelCustomer cust;
  final Hotel hotel;
  final Room room;
  final DateTime dateIn;
  final DateTime dateOut;

  HotelBookingInfo(this.cust, this.hotel, this.room, this.dateIn, this.dateOut);

  Map<String, dynamic> toMap() {

    /*
    {
      "cityID": "18943",
      "checkInDate": "2022-08-16T06:43:25.491Z",
      "checkOutDate": "2022-08-17T06:43:25.491Z",
      "internalCode": "SUP",
      "hotelID": "2068046~||~10",
      "breakfast": "Breakfast for 2 people",
      "roomID": "12031833|166979217|11334720|0f5cb2b5-0c47-3e55-8f13-a7a15bf25b18~||~2068046~||~10~||~SUP",
      "isRequestChildBed": false,
      "title": "MR",
      "firstName": "Datu",
      "lastName": "Rajab",
      "isSmokingRoom": false,
      "phone": "085655308669",
      "email": "munanjar@gmail.com",
      "requestDescription": "-",
      "bedTypeID": "0",
      "bedTypeBed": "FullBed",
      "agentOsRef": "TH000001"
    }
     */

    return {
      "cityID": hotel.city.id,
      "checkInDate": DateFormat("yyyy-MM-dd").format(dateIn),
      "checkOutDate": DateFormat("yyyy-MM-dd").format(dateOut),
      "internalCode": hotel.internalCode,
      "hotelID": hotel.id,
      "breakfast": room.breakfast,
      "roomID": room.id,
      "isRequestChildBed": false,
      "title": cust.title,
      "firstName": cust.firstName,
      "lastName": cust.lastName,
      "isSmokingRoom": false,
      "phone": cust.phone,
      "email": cust.email,
      "requestDescription": "-",
      "bedTypeID": room.id,
      "bedTypeBed": room.name,
      "agentOsRef": "TH000001"
    };
  }
}