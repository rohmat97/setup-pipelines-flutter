import 'package:flutter/material.dart';
import 'package:kai_wisata/home/models/histories/history_booking_model.dart';
import 'package:kai_wisata/home/models/history_payment.dart';
import 'package:kai_wisata/helpers/theme.dart';

import '../../commons/models/transaction.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class OtherBookingCard extends StatelessWidget {
  OtherBookingCard({
    Key? key,
    this.histories,
    this.onTap,
    this.pathAsset,
  }) : super(key: key);

  final HistoryBookingModel? histories;
  final VoidCallback? onTap;
  final String? pathAsset;
  MaterialColor statusColor = Colors.red;
  String statusPay = '';

  Widget buildTicketRoute() {
    return Text(
      "${histories?.details?[0].bookingData!.routeInfo![0].org} - ${histories?.details?[0].bookingData!.routeInfo![0].des}",
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: KaiColor.black,
      ),
    );
  }

  Widget buildTrainName() {
    return Text(
      "${histories?.details?[0].bookingData!.routeInfo![0].transporterName} - ${histories?.details?[0].bookingData!.routeInfo![0].transporterNo}",
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KaiColor.black,
      ),
    );
  }

  Widget buildDateSchedule() {
    return Text(
      DateFormat("dd MMM yyyy HH:mm a").format(histories!.details![0].bookingData!.routeInfo![0].depDate!),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KaiColor.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (histories?.paymentStatus == "NOT_PAID") {
      statusColor = Colors.red;
      statusPay = "Unpaid";
    } else if (histories?.paymentStatus == "PAID") {
      statusColor = Colors.yellow;
      statusPay = "Paid";
    } else if (histories?.paymentStatus == "COMPLETED") {
      statusColor = Colors.green;
      statusPay = "Completed";
    } else if (histories?.paymentStatus == "EXPIRED") {
      statusColor = Colors.red;
      statusPay = "Canceled";
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: KaiColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: KaiColor.homeBackground,
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: statusColor,
                  ),
                ),
                const SizedBox(width: 6),
                 Text(
                  statusPay,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(pathAsset!),
                  width: 46,
                  height: 35,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTicketRoute(),
                    const SizedBox(height: 3),
                    buildTrainName(),
                    const SizedBox(height: 3),
                    buildDateSchedule(),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 20,
            thickness: .25,
            color: KaiColor.black,
          ),
           Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Text(
              "Transaction ID : ${histories?.invoiceNumber}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: KaiColor.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
