class SeatMap {
  bool? success;
  String? message;
  Map<String, dynamic>? data;

  SeatMap({
    this.success,
    this.message,
    this.data,
  });

  SeatMap.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  SeatMap.fromLocalJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }

  static List<SeatMap> listFromJson(List<dynamic> json) => json.map((e) => SeatMap.fromJson(e)).toList();
}
