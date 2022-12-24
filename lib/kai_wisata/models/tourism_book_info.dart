import 'package:intl/intl.dart';

class TourismBookInfo {
  /*
    {
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
    }
     */

  final String org;
  final String des;
  final DateTime depTime;
  final DateTime arvTime;
  final String skema;
  final String transporterNo;
  final String transporterName;
  final int gerbongId;
  final String gerbongTipe;
  final String layanan;
  final String notes;
  final int total;
  final String title;
  final String name;
  final String email;
  final String phone;
  final String company;
  final String address;
  final String idCardType;
  final String idCardNumber;

  TourismBookInfo(
      this.org,
      this.des,
      this.depTime,
      this.arvTime,
      this.skema,
      this.transporterNo,
      this.transporterName,
      this.gerbongId,
      this.gerbongTipe,
      this.layanan,
      this.notes,
      this.total,
      this.title,
      this.name,
      this.email,
      this.phone,
      this.company,
      this.address,
      this.idCardType,
      this.idCardNumber);

  factory TourismBookInfo.fromJson(json) {
    return TourismBookInfo(
        json["org"],
        json["des"],
        DateFormat("yyyy-MM-dd HH:mm").parse(json["dep_datetime"]),
        DateFormat("yyyy-MM-dd HH:mm").parse(json["arv_datetime"]),
        json["skema"],
        json["transporter_no"],
        json["transporter_name"],
        json["gerbong_id"],
        json["gerbong_tipe"],
        json["layanan"],
        json["notes"],
        json["total"],
        json["title"],
        json["name"],
        json["email"],
        json["phone"],
        json["company"],
        json["address"],
        json["id_card_type"],
        json["id_card_number"]);
  }

  String get duration {
    var diff = arvTime.difference(depTime);
    var hours = (diff.inMinutes / 60).round();
    var minutes = diff.inMinutes - (hours * 60);

    var str = "";
    if (hours > 0) {
      str = str + '$hours j';
    }
    if (minutes > 0) {
      str = str + " $minutes m";
    }
    return str;
  }

  get totalFormatted => NumberFormat.decimalPattern("Id").format(total);

  Map<String, dynamic> toJson() {
    return {
      "org": org,
      "des": des,
      "depTime": depTime,
      "arvTime": arvTime,
      "skema": skema,
      "transporterNo": transporterNo,
      "transporterName": transporterName,
      "gerbongId": gerbongId,
      "gerbongTipe": gerbongTipe,
      "layanan": layanan,
      "notes": notes,
      "total": total,
      "title": title,
      "name": name,
      "email": email,
      "phone": phone,
      "company": company,
      "address": address,
      "idCardType": idCardType,
      "idCardNumber": idCardNumber
    };
  }
}
