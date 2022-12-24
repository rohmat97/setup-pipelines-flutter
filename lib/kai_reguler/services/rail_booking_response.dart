
import '../../data/models/station.dart';

class RailBookingResponse {
  final String message;
  final int errorNumber;
  final String gdsBookCode;

  RailBookingResponse(this.message, this.errorNumber, this.gdsBookCode);

  factory RailBookingResponse.fromJson(Map<String, dynamic> json){
    String? errorNumAsString = json["data"]["err_num"];
    if (errorNumAsString != null && int.parse(errorNumAsString) == 0) {
      var gdsBookCode = json["data"]["result"]["gds_book_code"];

      return RailBookingResponse("", 0, gdsBookCode);
    } else if (errorNumAsString != null && int.parse(errorNumAsString) == 0) {
      return RailBookingResponse(
          json["message"], int.parse(errorNumAsString), "");
    } else {
      return RailBookingResponse(json["message"], -1, "");
    }
  }
}