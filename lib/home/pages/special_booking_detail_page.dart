import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_istimewa/models/special_booking.dart';
import 'package:kai_wisata/kai_istimewa/widgets/special_detail_card.dart';

import '../arguments/transaction_arguments.dart';
import '../widgets/special_booking_detail_card.dart';
import '../widgets/special_booking_price_detail.dart';
import '../widgets/special_prie_detail.dart';

class SpecialBookingDetailPage extends StatefulWidget {
  static const routeName = '/special-booking-detail-pages';

  const SpecialBookingDetailPage({Key? key}) : super(key: key);

  @override
  State<SpecialBookingDetailPage> createState() => _SpecialBookingDetailPageState();
}

class _SpecialBookingDetailPageState extends State<SpecialBookingDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final args =
    ModalRoute.of(context)!.settings.arguments as TransactionArguments;
    // Transaction trans = args.transaction;
    // SpecialBookingInfo info = trans.specialBookInfo;

    return Scaffold(
      backgroundColor: KaiColor.neutral11,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: KaiColor.blue,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            20.0,
                          ),
                          child: InkWell(
                            child: SvgPicture.asset(
                              'assets/svg/arrow_left.svg',
                              height: 18,
                              color: KaiColor.white,
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // "${info.org} - ${info.des}",
                              '',
                              style: KaiTextStyle.titleSmallBold.apply(
                                color: KaiColor.white,
                              ),
                            ),
                            Text(
                              // 'Booking ID ${args.transaction.invoiceNo}',
                              'Booking ID ',
                              style: KaiTextStyle.titleSmallThin.apply(
                                color: KaiColor.white,
                                fontSizeDelta: -2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(''),
                    const Text(''),
                    Text(
                      // trans.code,
                      '',
                      style: KaiTextStyle.bodyLargeBold.apply(
                        color: KaiColor.blue,
                        fontSizeDelta: 5,
                      ),
                    ),
                    const Text(''),
                    const Text(''),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 18.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Train Itinerary',
                  style: KaiTextStyle.bodyLargeBold.apply(
                    color: KaiColor.black,
                  ),
                ),
              ),
              // SpecialBookingDetailCard(content: args.transaction.specialBookInfo,),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Price Details',
                  style: KaiTextStyle.bodyLargeBold.apply(
                    color: KaiColor.black,
                  ),
                ),
              ),
              // SpecialBookingPriceDetail(args: args.transaction.specialBookInfo),
            ],
          ),
        ),
      ),
    );
  }
}
