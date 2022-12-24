import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/models/station.dart';
import '../../services/regular_ticket_service.dart';

class StationCaches {
  Box? box;
  StationCaches._privateConstructor();

  void init() async {
    box = await Hive.openBox<void>((StationCaches).toString());
    var response = await RegularTicketService.fetchStations();
    save(response.origins);
  }

  static final StationCaches _instance = StationCaches._privateConstructor();
  static StationCaches get instance => _instance;

  void save(Iterable<Station> stations) {
    for (Station station in stations) {
      box?.put(station.code, station.name);
    }
  }

  String get(String code){
    return box?.get(code, defaultValue: "");
  }
}