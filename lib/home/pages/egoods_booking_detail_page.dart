import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/digital_goods/models/buy_info.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/providers/rail_booking_detail_state.dart';
import 'package:kai_wisata/home/widgets/egoods_booking_card.dart';
import 'package:kai_wisata/home/widgets/egoods_price_detail.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';
import 'package:kai_wisata/widgets/kai_card.dart';
import 'package:kai_wisata/widgets/kai_last_transaction.dart';
import 'package:kai_wisata/widgets/kai_passenger_list.dart';
import 'package:kai_wisata/widgets/kai_points.dart';
import 'package:kai_wisata/widgets/kai_price_detail.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../widgets/kai_train_detail.dart';
import '../arguments/transaction_arguments.dart';

class EGoodsBookingDetailPage extends StatefulWidget {
  static const routeName = '/egoods-booking-detail-pages';

  const EGoodsBookingDetailPage({Key? key}) : super(key: key);

  @override
  State<EGoodsBookingDetailPage> createState() => _EGoodsBookingDetailPageState();
}

class _EGoodsBookingDetailPageState extends State<EGoodsBookingDetailPage> {

  Transaction? trans;
  BuyInfo get buyInfo => trans!.buyInfo;

  @override
  Widget build(BuildContext context) {

    final args =
    ModalRoute.of(context)!.settings.arguments as TransactionArguments;
    trans = args.bookingModel as Transaction?;

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
                              // args.transaction.transactionType,
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
               EGoodsPriceDetail(content: buyInfo,),
            ],
          ),
        ),
      ),
    );
  }
}
