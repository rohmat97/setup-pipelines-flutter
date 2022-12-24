import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/models/buy_info.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';

class EGoodsPriceDetail extends StatelessWidget {
  const EGoodsPriceDetail({
    Key? key,
    this.content,
    this.onTap,
  }) : super(key: key);

  final BuyInfo? content;
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
                      "${content?.productCode}",
                      style: KaiTextStyle.bodyLargeMedium.apply(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      '${content?.destination}',
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
                      'Rp ${content?.priceFormatted}',
                      style: KaiTextStyle.bodyLargeBold.apply(
                        color: KaiColor.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
