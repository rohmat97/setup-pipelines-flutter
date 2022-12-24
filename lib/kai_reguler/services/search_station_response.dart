
import '../../data/models/station.dart';

class SearchStationResponse {
  final String message;
  final int errorNumber;
  final List<Station> origins;
  final List<Station> destinations;

  SearchStationResponse(this.message, this.errorNumber, this.origins, this.destinations);

  factory SearchStationResponse.fromJson(Map<String, dynamic> json){
      List<dynamic> listOrigins = json["data"];
      List<Station> tmpOrigins = [];
      for (Map<String, dynamic> origin in listOrigins) {
        tmpOrigins.add(Station.fromJson(origin));
      }

      List<dynamic> listDestinations = json["data"];
      List<Station> tmpDestinations = [];
      for (Map<String, dynamic> destination in listDestinations) {
        tmpDestinations.add(Station.fromJson(destination));
      }

      return SearchStationResponse("", 0, tmpOrigins, tmpDestinations);
  }
}