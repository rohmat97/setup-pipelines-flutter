class SeatsMap {
  int? columns;
  int? rowSeat;
  int? columnSeat;
  String? aplhaSeat;
  String? classSeat;
  int? filledSeat;

  SeatsMap({
    this.columns,
    this.rowSeat,
    this.columnSeat,
    this.aplhaSeat,
    this.classSeat,
    this.filledSeat,
  });

  SeatsMap.fromJson(Map<String, dynamic> json) {
    columns = json['columns'];
    rowSeat = json['rows_seats'];
    columnSeat = json['column_seats'];
    aplhaSeat = json['aplha_seats'];
    classSeat = json['class_seats'];
    filledSeat = json['filled_seats'];
  }

  Map<String, dynamic> toJson() {
    return {
      "columns": columns,
      "rows_seats": rowSeat,
      "column_seats": columnSeat,
      "aplha_seats": aplhaSeat,
      "class_seats": classSeat,
      "filled_seats": filledSeat,
    };
  }

  static List<SeatsMap> listFromJson(List<dynamic> json) => json.map((e) => SeatsMap.fromJson(e)).toList();
}
