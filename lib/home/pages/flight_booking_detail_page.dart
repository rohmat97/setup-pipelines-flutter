import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/arguments/histories_arguments.dart';
import 'package:kai_wisata/home/models/histories/history_booking_model.dart';
import 'package:kai_wisata/home/providers/flight_booking_detail_state.dart';
import 'package:kai_wisata/widgets/flight_plane_detail.dart';
import 'package:kai_wisata/widgets/kai_passenger_list.dart';
import 'package:kai_wisata/widgets/kai_price_detail.dart';
import 'package:kai_wisata/widgets/kai_train_detail.dart';
import 'package:provider/provider.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class FlightBookingDetailPage extends StatefulWidget {
  static const routeName = '/flight-booking-detail-pages';
  const FlightBookingDetailPage({Key? key}) : super(key: key);

  @override
  State<FlightBookingDetailPage> createState() => _FlightBookingDetailPageState();
}

class _FlightBookingDetailPageState extends State<FlightBookingDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  FlightBookingDetailState state = FlightBookingDetailState();

  HistoryBookingModel? histories;

  @override
  Widget build(BuildContext context) {

    final args =
    ModalRoute.of(context)!.settings.arguments as HistoriesArguments;

    state = Provider.of<FlightBookingDetailState>(context);
    state.initState(context, scaffoldKey);
    histories = args.booking;

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
                            onTap: () => state.onBackButton(),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${histories?.details?[0].bookingData!.routeInfo![0].org} - ${histories?.details?[0].bookingData!.routeInfo![0].des}",
                              // '',
                              style: KaiTextStyle.titleSmallBold.apply(
                                color: KaiColor.white,
                              ),
                            ),
                            Text(
                              'Booking ID ${histories!.invoiceNumber}',
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
                      'Booking Code',
                      style: KaiTextStyle.bodyLargeRegular
                          .apply(color: KaiColor.black),
                    ),
                    Row(
                      children: histories!.details!.map((dt) => Text(
                        '${dt.bookingData?.bookingCode}',
                        // '',
                        style: KaiTextStyle.bodyLargeBold.apply(
                          color: KaiColor.blue,
                          fontSizeDelta: 5,
                        ),
                      ),).toList(),
                    ),
                    const Text(''),
                    const Text(''),
                  ],
                ),
              ),
              Center(
                child: Container(
                  color: KaiColor.white,
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  // child: SfBarcodeGenerator(
                  //     value: histories!.bookingData!.bookingCode!,
                  //     symbology: QRCode(),
                  //     showValue: false,
                  // ),
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
              // FlightPlaneDetail(contents: histories!.bookingData!,),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Passenger',
                  style: KaiTextStyle.bodyLargeBold.apply(
                    color: KaiColor.black,
                  ),
                ),
              ),
              // ...(bookingInfo.paxInfos.asMap().map((i, e) =>
              //     MapEntry(i, KaiPassengerList(idx : i, content: e, ticket: bookingInfo.routeInfo.tickets[i],))).values),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 18.0,
              //     right: 18.0,
              //     top: 10.0,
              //     bottom: 10.0,
              //   ),
              //   child: Text(
              //     'Price Details',
              //     style: KaiTextStyle.bodyLargeBold.apply(
              //       color: KaiColor.black,
              //     ),
              //   ),
              // ),
              //  KaiPriceDetail(content: bookingInfo.routeInfo,),
            ],
          ),
        ),
      ),
    );
  }
}