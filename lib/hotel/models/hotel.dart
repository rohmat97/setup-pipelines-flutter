import 'package:kai_wisata/hotel/models/room.dart';

import 'city.dart';

class Hotel {

  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.message,
    required this.city,
    required this.rooms,
    required this.lowestPrice,
    required this.distance,
    required this.rate,
    required this.stars,
    required this.photos,
    required this.internalCode,
    required this.available,
  });

  String id;
  String name;
  String address;
  String message;
  City city;
  List<Room> rooms;
  double lowestPrice;
  double distance;
  double rate;
  int stars;
  List<String> photos;
  String internalCode;
  bool available;

  /*
  "name": "Sutan Raja Hotel And Convention Centre",
      "ID": "566953~||~10",
      "rating": 4,
      "email": "",
      "address": "Jl. Raya Soreang No. 10 Km. 17,,Bandung",
      "internalCode": "SUP",
      "logo": "https://61.8.74.42:7080/H2H/hotel/logo?id=566953",
      "availabilityStatus": true,
      "bookingDaysBefore": 0,
      "market": null,
      "message": "Sutan Raja Hotel And Convention Centre berbintang 4 ini menawarkan kenyamanan kepada Anda baik untuk keperluan bisnis maupun berwisata di Bandung. Menampilkan daftar fasilitas yang lengkap, tamu akan merasakan bahwa mereka menginap di properti yang nyaman. Layanan kamar 24 jam, resepsionis 24 jam, penyimpanan barang, Wi-fi di tempat umum, tempat parkir mobil ada untuk kenikmatan para tamu. Kamar dilengkapi dengan segala fasilitas yang Anda butuhkan untuk bermalam dengan nyaman. Di beberapa kamar terdapat teh gratis, handuk, lantai karpet, sandal, kopi instan gratis. Akses ke pusat kebugaran, kolam renang luar ruangan, spa, klub anak-anak, kolam renang anak di hotel akan meningkatkan kepuasan menginap Anda. Staf yang ramah, fasilitas yang istimewa dan dekat dengan semua yang Bandung tawarkan, merupakan tiga alasan utama Anda untuk menginap di Sutan Raja Hotel And Convention Centre.",
      "phone": "",
      "website": "",
      "promoEndDate": null,
      "priceStart": 458278,
      "facilities": [
        "Spa",
        "Laundry"
      ],
      "ratingAverage": 5
   */

  static String get defaultLogo => 'iVBORw0KGgoAAAANSUhEUgAAAJAAAACQCAYAAADnRuK4AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAAGfSURBVHhe7d2hEQIxEEDRQAl4JP0XhMTTAiDSAPdNAu+Zi72ZPzvr9vT6GHDQeX7hEAGRCIhEQCQCIhEQiYBIBEQiIBIBkQiIREAkAiIREImASAREIiASAZEIiERAJAIiERCJgEgERCIgEgGRCIhEQCQCIhEQiYBIBEQiIBIBkQiIREAkAiIREImASAREIiASAZEIiERAJAIi2eJaz/N6m6//cnnc52tdJhCJgEgERCIgkm2X6B0WzG/s+o8mEImASAREIiASAZEIiERAJAIiERCJgEgERCIgEgGRCIhEQCQCIhEQiYBIBEQiIBIBkQiIREAkAiIREImASAREIiASAZEIiERAJAIiERCJgEgERCIgEgGRCIhEQCQCIhEQiYBIBEQiIBIXCxfm2Ao/T0AkAiIREMkWSzTrMoFIBEQiIBIBkQiIREAkAiIREImASAREIiASAZEIiERAJAIiERCJgEgERCIgEgGRCIhEQCQCIhEQiYBIBEQiIBIBkQiIREAkAiIREImASAREIiASAZEIiERAJAIiERCJgEgERDDGG+GCIQiLxjoVAAAAAElFTkSuQmCC';

  factory Hotel.fromJson(City city, Map<String, dynamic> data) {
    return Hotel(
      id: data["ID"],
      name: data['name'],
      address: data['address'],
        message: data['message'],
      city: city,
      rooms: [],
      lowestPrice: double.tryParse(data['priceStart'].toString()) ?? 0,
      distance: 0,
      rate: double.tryParse(data['ratingAverage'].toString()) ?? 0,
      stars: (double.tryParse(data['rating'].toString()) ?? 0).toInt(),
      photos: [
        data['logo'] ?? defaultLogo
      ],
      internalCode: data["internalCode"],
      available: data["availabilityStatus"]
    );
  }

  static List<Hotel> listFromJson(City city, List<dynamic> json) => json.map((e) => Hotel.fromJson(city, e)).toList();
}


