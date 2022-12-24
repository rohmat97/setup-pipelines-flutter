import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_route_info_model.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';

class KaiPriceDetailOther extends StatelessWidget {
  const KaiPriceDetailOther({
    Key? key,
    this.content,
    this.onTap,
  }) : super(key: key);

  final List<HistoryBookingDataRouteInfoModel>? content;
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${content?[0].transporterName} x${content?[0].tickets?.length}",
                      // '',
                      style: KaiTextStyle.bodyLargeMedium.apply(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      'Rp ${content?[0].basicFare}',
                      // '',
                      style: KaiTextStyle.bodyLargeMedium.apply(
                        color: KaiColor.black,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Additional Fee',
                      style: KaiTextStyle.bodyLargeMedium.apply(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      'Rp ${content?[0].additionalFee}',
                      // '',
                      style: KaiTextStyle.bodyLargeMedium.apply(
                        color: KaiColor.black,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: KaiTextStyle.bodyLargeBold.apply(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      'Rp ${content?[0].totalPrice}',
                      // '',
                      style: KaiTextStyle.bodyLargeBold.apply(
                        color: KaiColor.black,
                      ),
                    ),
                  ],
                ),
                // const Divider(),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0),
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Text(
                //       'SEND RECEIPT',
                //       style: KaiTextStyle.bodyLargeBold.apply(
                //         color: KaiColor.blue,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
