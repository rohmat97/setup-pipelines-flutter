import 'package:kai_wisata/base_service.dart';
import 'package:kai_wisata/kai_istimewa/models/special_booking.dart';

import '../../kai_reguler/services/search_station_response.dart';
import '../models/special_description.dart';

class SpecialServices extends BaseService {

  static Future<SearchStationResponse> fetchStations() async {
    String endPoint = "/kaistimewa/getStation";
    var json = await BaseService.get(endPoint);
    return SearchStationResponse.fromJson(json);
  }

  static book(SpecialBookingInfo info) async {
    String url = "/kaistimewa/booking";
    var json = await BaseService.post(url, info.toMap());
    return json["data"];
  }

  static Future<SpecialDescription> getDescription() async {
    String endPoint = "/kaistimewa/deskripsi";
    var json = await BaseService.get(endPoint);
    return SpecialDescription.fromJson(json["data"]);
  }

}