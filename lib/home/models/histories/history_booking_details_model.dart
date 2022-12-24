import 'package:intl/intl.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_model.dart';

class HistoryBookingDetailsModel {
  int? id;
  int? transactionId;
  int? productTypeId;
  int? bookingId;
  double? amount;
  String? note;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  HistoryBookingDataModel? bookingData;
  
  HistoryBookingDetailsModel({
    this.id,
    this.transactionId,
    this.productTypeId,
    this.bookingId,
    this.amount,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  HistoryBookingDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    transactionId = json["transaction_id"];
    productTypeId = json["product_type_id"];
    bookingId = json["booking_id"];
    amount = double.parse(json["amount"].toString());
    note = json["note"];
    status = json["status"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
    bookingData = HistoryBookingDataModel.fromJson(json["booking_data"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_id': transactionId,
      "product_type_id": productTypeId,
      "booking_id": bookingId,
      "amount": amount?.toString(),
      "note": note,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
      'booking_data': bookingData?.toJson(),
    };
  }
}

class UninitializedHistoryBookingDetailsModel extends HistoryBookingDetailsModel {}
