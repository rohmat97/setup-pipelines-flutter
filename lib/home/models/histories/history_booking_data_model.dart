import 'package:intl/intl.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_caller_model.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_route_info_model.dart';

class HistoryBookingDataModel {
  int? id;
  int? userId;
  String? token;
  String? bookingCode;
  String? bookingCodeTransporter;
  String? bookingDate;
  String? bookingTimeLimit;
  String? bookingStatus;
  String? refDepart;
  String? refReturn;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? routeType;
  List<HistoryBookingDataRouteInfoModel>? routeInfo;
  HistoryBookingDataCallerModel? caller;

  HistoryBookingDataModel({
    this.id,
    this.userId,
    this.token,
    this.bookingCode,
    this.bookingCodeTransporter,
    this.bookingDate,
    this.bookingTimeLimit,
    this.bookingStatus,
    this.refDepart,
    this.refReturn,
    this.createdAt,
    this.updatedAt,
    this.routeType,
    this.routeInfo,
    this.caller,
  });

  HistoryBookingDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    token = json["token"];
    bookingCode = json["booking_code_gds"] ?? json["booking_code"];
    bookingCodeTransporter = json["booking_code_transporter"] ?? '';
    bookingDate = json["booking_date"];
    bookingTimeLimit = json["booking_time_limit"];
    bookingStatus = json["booking_status"];
    refDepart = json["ref_depart"] != '' ? json["ref_depart"] : '';
    refReturn = json["ref_return"] != '' ? json["ref_return"] : '';
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
    routeType = json["route_type"];
    routeInfo = json["route_info"]
        .map<HistoryBookingDataRouteInfoModel>(
            (ri) => HistoryBookingDataRouteInfoModel.fromJson(ri))
        .toList();
    caller = HistoryBookingDataCallerModel.fromJson(json["caller"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'token': token,
      'booking_code': bookingCode,
      'booking_code_transporter': bookingCodeTransporter,
      'booking_date': bookingDate,
      'booking_time_limit': bookingTimeLimit,
      'booking_status': bookingStatus,
      'ref_depart': refDepart,
      'ref_return': refReturn,
      'created_at': createdAt?.toString(),
      'updated_at': updatedAt?.toString(),
      'route_type': routeType,
      'route_info': routeInfo?.map((ri) => ri.toJson()).toList(),
      'caller': caller?.toJson(),
    };
  }
}

class UninitializedHistoryBookingDataModel extends HistoryBookingDataModel {}
