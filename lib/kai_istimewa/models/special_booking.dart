import 'package:kai_wisata/data/models/station.dart';
import 'package:intl/intl.dart';

class SpecialBookingInfo {
    /*
  "org": "BD",
  "des": "GMR",
  "dep_datetime": "2022-09-20 10:10",
  "arv_datetime": "2022-09-21 07:10",
  "skema": "FIT/Perseorangan",
  "transporter_no": "43A",
  "transporter_name": "ARGO PARAHYANGAN",
  "gerbong_id": 1,
  "gerbong_tipe": "Nusantara",
  "layanan": "string",
  "notes": "Perlu makanan ringan manis dan asin",
  "total": 0,
  "title": "Mr.",
  "name": "Datu Rajab",
  "email": "fulan@mail.com",
  "phone": "08123456789",
  "company": "PT.FULAN",
  "address": "Jl. Gatot Subroto",
  "id_card_type": "NIK",
  "id_card_number": "812081289"
   */

    final Station org;
    final Station des;
    final DateTime departure;
    final String layanan;
    final String note;
    final int penumpang;
    final int total;
    final String title;
    final String name;
    final String email;
    final String phone;
    final String company;
    final String address;
    final String idCardType;
    final String idCardNumber;

    SpecialBookingInfo(this.org, this.des, this.departure, this.layanan,
        this.note, this.total, this.penumpang,
        this.title, this.name, this.email, this.phone, this.company,
        this.address, this.idCardType, this.idCardNumber);

    Map<String, dynamic> toMap() {
        return {
            "org": org.code,
            "des": des.code,
            "dep_datetime": DateFormat("yyyy-MM-dd HH:mm").format(departure),
            "layanan": layanan,
            "notes": note,
            "penumpang": 0,
            "total": 0,
            "title": title,
            "name": name,
            "email": email,
            "phone": phone,
            "company": company,
            "address": address,
            "id_card_type": idCardType,
            "id_card_number": idCardNumber
        };
    }

  factory SpecialBookingInfo.fromJson(json) {
      return SpecialBookingInfo(
          Station(json["org"], json["org"]),
          Station(json["des"],json["des"]),
          DateFormat("yyyy-MM-dd HH:mm").parse(json["dep_datetime"]),
          json["layanan"],
          json["notes"],
          json["penumpang"],
          json["total"],
          json["title"],
          json["name"],
          json["email"],
          json["phone"],
          json["company"],
          json["address"],
          json["id_card_type"],
          json["id_card_number"]
      );
  }
}