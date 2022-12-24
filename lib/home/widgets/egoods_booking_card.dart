import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/models/buy_info.dart';
import 'package:kai_wisata/home/models/history_payment.dart';
import 'package:kai_wisata/helpers/theme.dart';

import '../../commons/models/transaction.dart';
import 'package:intl/intl.dart';

class EGoodsBookingCard extends StatelessWidget {
  const EGoodsBookingCard({
    Key? key,
    this.payment,
    this.onTap,
  }) : super(key: key);

  final Transaction? payment;
  final VoidCallback? onTap;
  BuyInfo get buyInfo => payment!.buyInfo;

  Widget buildTicketRoute() {
    return Text(
      buyInfo.productCode,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: KaiColor.black,
      ),
    );
  }

  Widget buildTrainName() {
    return Text(
      buyInfo.destination,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: KaiColor.black,
      ),
    );
  }

  Widget buildDateSchedule() {
    return Text(
      DateFormat("dd MMM yyyy HH:mm").format(payment!.transactionDate),
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: KaiColor.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    color: payment!.status!.color,
                  ),
                ),
                const SizedBox(width: 6),
                 Text(
                  "${payment?.status.display}",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: payment!.status.color,
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
                const Image(
                  image: AssetImage('assets/images/ic_bill.png'),
                  width: 23,
                  height: 17,
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
              "Transaction ID : ${payment?.code}",
              style: const TextStyle(
                fontSize: 8,
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
