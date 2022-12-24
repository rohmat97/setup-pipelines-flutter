import 'package:kai_wisata/kai_wisata/models/tourism_tipe.dart';

class TourismCustomer {
  final String name;
  final String email;
  final String phone;
  final String company;
  final String address;
  final int seat;
  final String note;

  TourismCustomer(this.name, this.email, this.phone, this.company, this.address,
      this.seat, this.note);
  static TourismCustomer empty(TourismTipe tipe) {
    return TourismCustomer("", "", "", "", "", 1, "");
  }
}
