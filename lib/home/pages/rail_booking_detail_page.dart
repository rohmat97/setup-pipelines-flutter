import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_model.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_route_info_model.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_route_info_ticket_model.dart';
import 'package:kai_wisata/home/models/histories/history_booking_details_model.dart';
import 'package:kai_wisata/home/models/histories/history_booking_model.dart';
import 'package:kai_wisata/home/providers/rail_booking_detail_state.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_passenger_list.dart';
import 'package:kai_wisata/widgets/kai_passenger_list_other.dart';
import 'package:kai_wisata/widgets/kai_price_detail.dart';
import 'package:kai_wisata/widgets/kai_price_detail_other.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../widgets/kai_train_detail.dart';
import '../arguments/transaction_arguments.dart';

class RailBookingDetailPage extends StatefulWidget {
  static const routeName = '/rail-booking-detail-pages';

  const RailBookingDetailPage({Key? key}) : super(key: key);

  @override
  State<RailBookingDetailPage> createState() => _RailBookingDetailPageState();
}

class _RailBookingDetailPageState extends State<RailBookingDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  RailBookingDetailState state = RailBookingDetailState();

  List<HistoryBookingDataRouteInfoTicketModel> passengers = [];

  HistoryBookingModel? trans;
  List<HistoryBookingDetailsModel>? get details => trans?.details;
  HistoryBookingDataModel? get bookingInfo => trans?.details?[0].bookingData;
  List<HistoryBookingDataRouteInfoTicketModel>? get paxInfos =>
      trans?.details?[0].bookingData?.routeInfo?[0].tickets;
  List<HistoryBookingDataRouteInfoModel>? get routeInfo =>
      trans?.details?[0].bookingData?.routeInfo;

  // RailBookingInfo? get bookingInfos => bookingInfos;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TransactionArguments;

    state = Provider.of<RailBookingDetailState>(context);
    state.initState(context, scaffoldKey);
    trans = args.bookingModel;

    for (var dt in details!) {
      for (var ri in dt.bookingData!.routeInfo!) {
        for (var tc in ri.tickets!) {
          if (passengers.length < ri.tickets!.length) {
            passengers.add(tc);
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: KaiColor.neutral11,
      body: SafeArea(
        child: SizedBox(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...(args.bookingModel.details![0]
                                          .bookingData!.routeInfo!
                                          .map((rt) {
                                        return Column(
                                          children: [
                                            Text(
                                              "${rt.org} - ${rt.des}",
                                              style: KaiTextStyle.titleSmallBold
                                                  .apply(
                                                color: KaiColor.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList()),
                                      Text(
                                        'Booking ID ${args.bookingModel.invoiceNumber}',
                                        style:
                                            KaiTextStyle.titleSmallThin.apply(
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
                              Text(
                                "${bookingInfo?.bookingCode}",
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
                        Center(
                          child: Container(
                            color: KaiColor.white,
                            height: MediaQuery.of(context).size.width * 0.3,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: SfBarcodeGenerator(
                              value: "${bookingInfo?.bookingCode}",
                              symbology: QRCode(),
                              showValue: false,
                            ),
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
                        KaiTrainDetail(
                          content: bookingInfo,
                        ),
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
                        // ...(bookingInfo?.routeInfo?.paxInfos.asMap().map((i, e) =>
                        //     MapEntry(i, KaiPassengerList(idx : i, content: e, ticket: bookingInfo.routeInfo.tickets[i],))).values),
                        // ...(details?.map((dt) => null)),
                        KaiPassengerListOther(
                          ticket: passengers,
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
                        // KaiPriceDetail(content: bookingInfo.routeInfo,),
                        KaiPriceDetailOther(
                          content: routeInfo,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.zero,
                  width: double.infinity,
                  child: KaiButton(
                    text: 'E-Tiket',
                    // onClick: () => state.onNextButton(),
                    onClick: () async {
                      await saveFile();
                      // String filename =
                      //     await state.printETiket(bookingInfo?.bookingCode);
                      // Navigator.pushNamed(context, PdfViewerPage.routeName,
                      //     arguments: PdfViewerArguments(filename));
                    },
                    buttonColor: KaiColor.blue,
                    textColor: KaiColor.white,
                    sideColor: KaiColor.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   icon: const Icon(Icons.edit),
      //   label: const Text('Edit'),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<bool> saveFile() async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/PDF_Download";
        directory = Directory(newPath);

        String? bookingCode = bookingInfo?.bookingCode;
        File saveFile = File(directory.path + '/' + bookingCode! + '.pdf');
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        await state.printETiket(bookingInfo?.bookingCode, saveFile.path);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      print('permission request');
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}
