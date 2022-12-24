import 'package:kai_wisata/kai_reguler/models/seats/seats_map.dart';

class ListSeatsMap {
  int? columns;
  List<dynamic>? dataSeats;

  ListSeatsMap({
    this.columns,
    this.dataSeats,
  });

  ListSeatsMap.fromJson(Map<String, dynamic> json) {
    columns = json['columns'];
    dataSeats = json['data_seats'].map((ds) => SeatsMap.fromJson(ds)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'columns': columns,
      'data_seats': dataSeats?.map((e) => e.toJson()).toList(),
    };
  }

  static List<ListSeatsMap> listFromJson(List<dynamic> json) => json.map((e) => ListSeatsMap.fromJson(e)).toList();
}
