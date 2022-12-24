import 'package:intl/intl.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_route_info_ticket_model.dart';

class HistoryBookingDataRouteInfoModel {
  String? transporterType;
  String? transporterNo;
  String? transporterName;
  String? transporterBookCode;
  String? org;
  String? des;
  DateTime? depDate;
  DateTime? arvDate;
  String? bookStatus;
  String? ccy;
  double? basicFare;
  String? discount;
  String? additionalFee;
  double? totalPrice;
  List<HistoryBookingDataRouteInfoTicketModel>? tickets;
  
  HistoryBookingDataRouteInfoModel({
    this.transporterType,
    this.transporterNo,
    this.transporterName,
    this.transporterBookCode,
    this.org,
    this.des,
    this.depDate,
    this.arvDate,
    this.bookStatus,
    this.ccy,
    this.basicFare,
    this.discount,
    this.additionalFee,
    this.totalPrice,
    this.tickets,
  });

  HistoryBookingDataRouteInfoModel.fromJson(Map<String, dynamic> json) {
    transporterType = json["transporter_type"];
    transporterNo = json["transporter_no"].runtimeType == int ? json["transporter_no"].toString() : json["transporter_no"];
    transporterName = json["transporter_name"];
    transporterBookCode = json["transporter_book_code"];
    org = json["org"];
    des = json["des"];
    depDate = json["dep_date"].contains("/") ? Intl.withLocale('en', () => DateFormat("dd/MM/yyyy - HH:mm").parse(json["dep_date"])) : DateFormat("yyyy-MM-dd HH:mm:ss").parse(json["dep_date"]);
    arvDate = json["arv_date"].contains("/") ? Intl.withLocale('en', () => DateFormat("dd/MM/yyyy - HH:mm").parse(json["arv_date"])) : DateFormat("yyyy-MM-dd HH:mm:ss").parse(json["arv_date"]);
    bookStatus = json["book_status"];
    ccy = json["ccy"];
    basicFare = double.parse(json["basic_fare"].toString());
    discount = json["discount"];
    additionalFee = json["additional_fee"];
    totalPrice = double.parse(json["total_price"].toString());
    tickets = json["ticket"].map<HistoryBookingDataRouteInfoTicketModel>((ticket) => HistoryBookingDataRouteInfoTicketModel.fromJson(ticket)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'transporter_type': transporterType,
      'transporter_no': transporterNo,
      'transporter_name': transporterName,
      'transporter_book_code': transporterBookCode,
      'org': org,
      'des': des,
      'dep_date': depDate?.toString(),
      'arv_date': arvDate?.toString(),
      'book_status': bookStatus,
      'ccy': ccy,
      'basic_fare': basicFare,
      'discount': discount,
      'additional_fee': additionalFee,
      'total_price': totalPrice,
      'ticket': tickets?.map((tc) => tc.toJson()).toList(),
    };
  }
}

class UninitializedHistoryBookingDataRouteInfoModel extends HistoryBookingDataRouteInfoModel {}
