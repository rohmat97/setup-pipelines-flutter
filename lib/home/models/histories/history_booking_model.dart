import 'package:intl/intl.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_model.dart';
import 'package:kai_wisata/home/models/histories/history_booking_details_model.dart';
import 'package:kai_wisata/home/models/histories/history_booking_payment_model.dart';

class HistoryBookingModel {
  int? id;
  String? parentId;
  String? invoiceNumber;
  int? userId;
  String? transactionType;
  String? productType;
  // int? bookingId;
  String? total;
  // String? note;
  String? transactionStatus;
  String? paymentStatus;
  String? confirmationStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<HistoryBookingDetailsModel>? details;
  HistoryBookingPaymentModel? payment;
  
  HistoryBookingModel({
    this.id,
    this.parentId,
    this.invoiceNumber,
    this.userId,
    this.transactionType,
    this.productType,
    // this.bookingId,
    this.total,
    // this.note,
    this.transactionStatus,
    this.paymentStatus,
    this.confirmationStatus,
    this.createdAt,
    this.updatedAt,
    this.details,
    this.payment,
  });

  HistoryBookingModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    parentId = json["parent_id"];
    invoiceNumber = json["invoice_number"];
    userId = json["user_id"];
    transactionType = json["transaction_type"];
    productType = json["product_type"];
    // bookingId = json["booking_id"];
    total = json["total"];
    // note = json["note"];
    transactionStatus = json["transaction_status"];
    paymentStatus = json["payment_status"];
    confirmationStatus = json["confirmation_status"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
    details = json["details"].map<HistoryBookingDetailsModel>((dt) => HistoryBookingDetailsModel.fromJson(dt)).toList();
    payment = json["payments"] != null ? HistoryBookingPaymentModel.fromJson(json["payments"]) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'invoice_number': invoiceNumber,
      'user_id': userId,
      'transaction_type': transactionType,
      'product_type': productType,
      // 'booking_id': bookingId,
      'total': total,
      // 'note': note,
      'transaction_status': transactionStatus,
      'payment_status': paymentStatus,
      'confirmation_status': confirmationStatus,
      'created_at': createdAt?.toString(),
      'updated_at': createdAt?.toString(),
      'details': details?.map((dt) => dt.toJson()).toList(),
      'payments': payment?.toJson(),
    };
  }

  static List<HistoryBookingModel> listFromJson(List<dynamic> json) =>
      json.map((e) => HistoryBookingModel.fromJson(e)).toList();
}

class UninitializedHistoryBookingModel extends HistoryBookingModel {}
