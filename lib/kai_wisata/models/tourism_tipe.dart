import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:kai_wisata/data/cache/hive_repository.dart';

class TourismTipe {
  /*
  "name": "Bali",
      "layanan": "Ruang Tunggu VIP\nSajian Makan\nAneka Kudapan\nSajian Minuman\nHanduk Wajah\nKaraoke\nFilm/Video\nCrew Khusus VIP",
      "fasilitas": "Karaoke\nMakan & Minum\nMini Bar\nToilet",
      "seat": 16,
      "created_at": null,
      "modified_at": null,
      "deskripsi": "Interior kereta ini kental dengan nuansa budaya Bali. Di desain secara cantik dan apik dengan ukiran dan lukisan yang bernuansakan eksotika Pulau Dewata",
      "id": 2,
      "price": 1,
      "list_image": null,
      "created_by": null,
      "modified_by": null
   */

  // {
  //           "id": 1,
  //           "name": "Bali",
  //           "description": "Kereta Wisata Bali, interior kereta ini sangat kental dengan nuansa budaya Bali. Didesain secara cantik dan apik dengan bubuhan ukiran serta lukisan yang bernuansakan Pulau Dewata. Jika Anda naik Kereta Wisata Bali, maka Anda akan merasakan pengalaman seperti saat sedang berwisata di Bali.",
  //           "services": "Mini Bar, Ruang Utama, VVIP Room, Karaoke System, Bagasi 20 kg, Toilet eksklusif",
  //           "capacity": 20,
  //           "estimated_price": "35985000.0000"
  //       },

  /*{
      "id": 1,
      "name": "Bali",
      "description": "Kereta Wisata Bali, interior kereta ini sangat kental dengan nuansa budaya Bali. Didesain secara cantik dan apik dengan bubuhan ukiran serta lukisan yang bernuansakan Pulau Dewata. Jika Anda naik Kereta Wisata Bali, maka Anda akan merasakan pengalaman seperti saat sedang berwisata di Bali.",
      "services": "Mini Bar, Ruang Utama, VVIP Room, Karaoke System, Bagasi 20 kg, Toilet eksklusif",
      "capacity": 20,
      "estimated_price": "35985000.0000",
      "gallery_wagon": [
        "http://localhost:8029/images/KAI/Wisata/bali/bali_1.jpg",
        "http://localhost:8029/images/KAI/Wisata/bali/bali_2.jpg",
        "http://localhost:8029/images/KAI/Wisata/bali/bali_3.jpg",
        "http://localhost:8029/images/KAI/Wisata/bali/bali_4.jpg",
        "http://localhost:8029/images/KAI/Wisata/bali/bali_5.jpg",
        "http://localhost:8029/images/KAI/Wisata/bali/bali_6.jpg"
      ]
    },*/

  final int id;
  final String name;
  final String description;
  final double estimated_price;
  final int capacity;
  final String services;

  TourismTipe(this.id, this.name, this.description, this.estimated_price,
      this.capacity, this.services);

  factory TourismTipe.fromJson(json) {
    return TourismTipe(
        json["id"],
        json["name"],
        json["description"],
        double.parse(json['estimated_price'].toString()),
        json["capacity"],
        json['services']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "estimated_price": estimated_price,
      "capacity": capacity,
      "services": services,
    };
  }

  static TourismTipe deserialize(String str) =>
      TourismTipe.fromJson(jsonDecode(str));

  static String serialize(TourismTipe t) => jsonEncode(t.toJson());

  // @override
  // String getId() {
  //   return "$origin-$destination-${DateFormat("ddMMyyyy").format(departureTime)}";
  // }

  static List<TourismTipe> listFromJson(List<dynamic> json) =>
      json.map((e) => TourismTipe.fromJson(e)).toList();
}
