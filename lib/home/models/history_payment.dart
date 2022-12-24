
import 'package:flutter/material.dart';

enum BookingStatus {
  unpaid,
  processed,
  completed,
  canceled,
}

extension BookingStatusExtensions on BookingStatus {
  String get display {
    switch (this) {
      case BookingStatus.unpaid :
        return "NOT_PAID";
      case BookingStatus.processed :
        return "PAID";
      case BookingStatus.completed :
        return "COMPLETED";
      case BookingStatus.canceled :
        return "EXPIRED";
      default :
        return "NOT_PAID";
    }
  }

  MaterialColor get color {
    switch (this) {
      case BookingStatus.unpaid :
        return Colors.yellow;
      case BookingStatus.processed :
        return Colors.yellow;
      case BookingStatus.completed :
        return Colors.green;
      case BookingStatus.canceled :
        return Colors.red;
      default :
        return Colors.red;
    }
  }
}

class HistoryPayment {
  final String date;
  final String transactionId ;
  final String transactionType;
  final String description;
  final String detail;
  final int amount;
  final BookingStatus status;

  HistoryPayment(this.date, this.transactionId, this.transactionType, this.description, this.detail, this.amount, this.status);

  factory HistoryPayment.fromJson(Map<String, dynamic> json){
    return HistoryPayment(
      json["date"],
      json["transaction_id"],
      json["transaction_type"],
      json["description"],
      json["detail"],
      json["amount"],
      BookingStatus.canceled,
    );
  }

  static List<HistoryPayment> fromListJson(List<dynamic> jsonList) =>
      jsonList.map((j) => HistoryPayment.fromJson(j)).toList();

  excerpt(int i) {
    return (description.length <= i) ?
      description:
      description.substring(0, i-3) + "...";
  }
}