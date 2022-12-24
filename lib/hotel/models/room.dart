import 'hotel.dart';

class Room {
  Room({
    required this.hotel,
    required this.id,
    required this.name,
    required this.breakfast,
    required this.price,
    required this.hotelGroup,
    required this.availableRoom,
    required this.photos,
    required this.facilites
  });

  /*
        "ID": "12031833|166979217|11334720|0f5cb2b5-0c47-3e55-8f13-a7a15bf25b18~||~2068046~||~10~||~SUP",
        "breakfast": "Breakfast for 2 people",
        "name": "Smart Hollywood",
        "isOnRequest": false,
        "price": 292712,
        "bookingType": "Issued",
        "isPackageDeal": false,
        "promoCode": null,
        "hotelGroup": 10,
        "image": "https://61.8.74.42:7080/H2H/hotel/RoomImage?RoomID=2068046-12031833",
        "facilites": [
          "Toiletries",
          "Towels",
          "Free Wi-Fi in all rooms!",
          "Satellite/cable channels",
          "Telephone",
          "Air conditioning",
          "Linens",
          "Slippers",
          "Soundproofing",
          "Desk",
          "Closet",
          "In-room safe box"
        ]
  */

  // factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  // Map<String, dynamic> toJson() => _$RoomToJson(this);
  Hotel hotel;
  String id;
  String name;
  String breakfast;
  double price;
  int hotelGroup;
  int availableRoom;
  List<String> photos;
  List<String> facilites;

  static getFacilities(List<dynamic> json){
    List<String> rets = [];
    for(var dyn in json){
      rets.add(dyn as String);
    }
    return rets;
  }

  factory Room.fromJson(Hotel hotel, json) {
    return Room(
        hotel : hotel,
        id: json["ID"],
        name: json["name"],
        breakfast: json["breakfast"],
        price: json["price"],
        hotelGroup: json["hotelGroup"],
        availableRoom : 1,
        photos: [
          json["image"]
        ],
        facilites: getFacilities (json["facilites"])
    );
  }

  static List<Room> listFromJson(Hotel hotel, List<dynamic> json) => json.map((e) => Room.fromJson(hotel, e)).toList();
}