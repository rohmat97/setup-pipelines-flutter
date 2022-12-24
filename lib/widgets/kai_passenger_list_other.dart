import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_route_info_ticket_model.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';

class KaiPassengerListOther extends StatelessWidget {
  const KaiPassengerListOther({
    Key? key,
    // this.idx,
    // this.content,
    this.ticket,
    this.onTap,
  }) : super(key: key);

  final List<HistoryBookingDataRouteInfoTicketModel>? ticket;
  // final int? idx;
  // final RailPaxInfo? content;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: KaiColor.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: ticket != null ? ticket!.asMap().map((i, tc) {
                return MapEntry(i, Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${i+1}.',
                      style: KaiTextStyle.bodyLargeBold.apply(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      "${tc.name}",
                      style: KaiTextStyle.bodyLargeBold.apply(
                        color: KaiColor.black,
                      ),
                    ),
                    const Text(''),
                    const Text(''),
                    const Text(''),
                    Text(
                      "${tc.seat}",
                      style: KaiTextStyle.bodyLargeBold.apply(
                        color: KaiColor.yellow,
                      ),
                    ),
                  ],
                  // children: [
                  //   Text(
                  //     '${idx!+1}.',
                  //     style: KaiTextStyle.bodyLargeBold.apply(
                  //       color: KaiColor.black,
                  //     ),
                  //   ),
                  //   Text(
                  //     "${ticket?.name}",
                  //     style: KaiTextStyle.bodyLargeBold.apply(
                  //       color: KaiColor.black,
                  //     ),
                  //   ),
                  //   const Text(''),
                  //   const Text(''),
                  //   const Text(''),
                  //   Text(
                  //     "${ticket?.seat}",
                  //     style: KaiTextStyle.bodyLargeBold.apply(
                  //       color: KaiColor.yellow,
                  //     ),
                  //   ),
                  // ],
                ));
              }).values.toList() : [],
            ),
          ),
        ),
      ),
    );
  }
}
