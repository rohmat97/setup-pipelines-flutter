import 'package:kai_wisata/base_service.dart';
import 'package:intl/intl.dart';
import 'package:kai_wisata/kai_wisata/arguments/tourism_search_arguments.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_customer.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_tipe.dart';

import '../../kai_reguler/services/search_station_response.dart';
import '../models/tourism_schedule.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WisataService extends BaseService {
  static Future<SearchStationResponse> fetchStations() async {
    String endPoint = "/kawisata/getStation";
    var json = await BaseService.get(endPoint);
    return SearchStationResponse.fromJson(json);
  }

  static Future<List<TourismSchedule>> getRailSchedule(
      TourismSearchArguments arg) async {
    String endPoint = "/api/train/get_schedule_all";

    Map<String, dynamic> params = {
      "org": arg.from!.code,
      "des": arg.to!.code,
      "departure_date": DateFormat('yyyy-MM-dd').format(arg.fromDate!),
      "return_date": DateFormat('yyyy-MM-dd').format(arg.toDate!),
      "pax_adult": 1,
      "pax_infant": 0,
      "page": 1,
      "per_page": 10,
      "sort_by": "id",
      "order": "asc"
    };

    var json = await BaseService.post(endPoint, params);
    List<TourismSchedule> schedules = [];

    List<dynamic> listSchedules = json["data"]["departure"];

    // print(listSchedules);

    for (Map<String, dynamic> schedule in listSchedules) {
      schedules.add(TourismSchedule.fromJson(schedule));
    }
    return schedules;
  }

  static Future<List<TourismTipe>> listTipes() async {
    String endPoint = "/api/train/list_wagon?wagon_type=Wisata&wagon_id=";
    var json = await BaseService.get(endPoint);

    // print(json['data']);

    // // print(json['data'][0]);

    // return TourismTipe.listFromJson(json["data"]);

    List<TourismTipe> tipes = [];

    List<dynamic> listTipes = json["data"];

    // // print(listTipes);

    for (Map<String, dynamic> tipe in listTipes) {
      print(tipe);
      tipes.add(TourismTipe.fromJson(tipe));
    }

    print(tipes);
    return tipes;
  }

  static book(TourismSearchArguments searchArguments, TourismSchedule schedule,
      TourismTipe wagon, TourismCustomer newCust, seat, note) async {
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

    // var data = {
    //   "org": searchArguments.from!.code,
    //   "des": searchArguments.to!.code,
    //   "dep_datetime":
    //       DateFormat("yyyy-MM-dd HH:mm").format(searchArguments.fromDate!),
    //   "arv_datetime":
    //       DateFormat("yyyy-MM-dd HH:mm").format(searchArguments.toDate!),
    //   "skema": searchArguments.skema,
    //   "transporter_no": schedule.transporterNo,
    //   "transporter_name": schedule.transporterName,
    //   "gerbong_id": wagon.id,
    //   "gerbong_tipe": wagon.name,
    //   "layanan": "string",
    //   "notes": newCust.note,
    //   "total": 0,
    //   "title": "Mr.",
    //   "name": newCust.name,
    //   "email": newCust.email,
    //   "phone": newCust.phone,
    //   "company": newCust.company,
    //   "address": newCust.address,
    //   "id_card_type": "",
    //   "id_card_number": ""
    // };

    // print(data);
    // int contact_id = 1;

    Map<String, dynamic> dataPemesan = {
      "name": newCust.name,
      "email": newCust.email,
      "phone": "62" + newCust.phone,
      "company_name": newCust.company,
      "company_address": newCust.address
    };

    print(dataPemesan);

    String url = "/api/train/save_contact";
    var json = await BaseService.post(url, dataPemesan);

    // print(json);
    var contact_id = json['data']['id'];

    Map<String, dynamic> data = {
      "detail_train": {
        "org": searchArguments.from!.code,
        "des": searchArguments.to!.code,
        "departure_date":
            DateFormat("yyyy-MM-dd HH:mm").format(searchArguments.fromDate!),
        "return_date":
            DateFormat("yyyy-MM-dd HH:mm").format(searchArguments.toDate!),
        "train_number": schedule.transporterNo,
        "train_name": schedule.transporterName,
        "train_wagon": [wagon.id],
      },
      "contact_id": contact_id,
      "pax_amount": seat,
      "notes": note,
      "order_type": "Wisata",
    };

    print(jsonEncode(data));

    url = "/api/train/booking_spec";
    json = await BaseService.post(url, data);
    print(json);
    return json["data"];
  }
}
