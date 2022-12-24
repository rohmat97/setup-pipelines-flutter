import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/home/models/histories/history_booking_model.dart';

class TransactionArguments {
  // final Transaction transaction;
  final HistoryBookingModel bookingModel;

  TransactionArguments(this.bookingModel);
}