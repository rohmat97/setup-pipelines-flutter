// import 'package:json_annotation/json_annotation.dart';

// part 'hotel.g.dart';

// @JsonSerializable()
class Mice {
  Mice({
    required this.name,
    required this.address,
    required this.city,
    required this.price,
    required this.capacity,
    required this.rate,
    required this.photos,
  });

  // factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);
  // Map<String, dynamic> toJson() => _$HotelToJson(this);

  String name;
  String address;
  String city;
  double price;
  int capacity;
  double rate;
  List<String> photos;
}
