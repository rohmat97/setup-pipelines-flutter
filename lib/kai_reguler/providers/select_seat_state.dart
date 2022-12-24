import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/doku_payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/selected_payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';
import 'package:kai_wisata/kai_reguler/models/seats/seat_map.dart';
import 'package:kai_wisata/kai_reguler/pages/05selected_payment_page.dart';
import 'package:kai_wisata/kai_reguler/pages/select_seat_page.dart';
import 'package:kai_wisata/kai_reguler/services/regular_ticket_service.dart';

import 'package:intl/intl.dart';

import '../pages/06doku_payment_page.dart';

class SelectSeatState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  SelectedPaymentArguments? args;
  RailBookingInfo? bookingInfo;
  SeatMap? seatMap;
  bool isLoaded = false;

  Map<String, dynamic> reqSeatMap = {};
  Map<String, dynamic> seatChanged = {};
  List<String> wagonCode = [];
  List<String> wagonNum = [];
  List<String> seatsChanged = [];

  Map<String, dynamic> bookDetail = {};

  void initState(BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey, SelectedPaymentArguments args,) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  // void onNextButton() async {
  //   var url = await RegularTicketService.createPayment(args!.transactionId);

  //   Navigator.pushNamed(context!,
  //       DokuPaymentPage.routeName,
  //       arguments: DokuPaymentArguments(
  //           args!.schedule,
  //           args!.bookingCart,
  //           url)
  //   );
  //   //Navigator.pushNamed(context!, OrderedSuccessfullyPage.routeName);
  // }

  // void setListWagon(Map<String, dynamic> chSeatMap, RailBookingInfo bookingInfo) {
  //   var tc = 0;
  //   for (var ri in bookingInfo.routeInfo) {
  //     tc = ri.tickets.length;
  //   }

  //   if (wagonCode.length != tc) {
  //     wagonCode.add(chSeatMap["wagon_class"]);
  //     wagonNum.add(chSeatMap["wagon_num"].toString());
  //     if (seatsChanged.isNotEmpty) {
  //       seatsChanged = updateArray(seatsChanged, chSeatMap["seat_number"]);
  //       print(seatsChanged);
  //     } else {
  //       seatsChanged.add(chSeatMap["seat_number"]);
  //     }
  //     notifyListeners();
  //   }
    
  //   notifyListeners();
  // }

  void setChangeSeatMap(
    Map<String, dynamic> chSeatMap,
    List<String> wagonCode,
    List<String> wagonNum,
    List<String> seatsChanged,
  ) {
    Map<String, dynamic> toChSeatMap = {
      "booking_code": chSeatMap["booking_code"],
      "wagon_code": wagonCode,
      "wagon_no": wagonNum,
      "seat": seatsChanged,
    };
    reqSeatMap.addAll(toChSeatMap);
    
    notifyListeners();
  }

  void getBookingInfoOnce() async {

    if(!isLoaded) {
      bookingInfo = await RegularTicketService.getBookingInfo(args!.bookingCode);

      isLoaded = true;
      notifyListeners();
    }
  }

  void getSeatMap(String bookingCode) async {
    if (!isLoaded) {
      seatMap = await RegularTicketService.getSeatMap(bookingCode);
      // print(seatMap);
      isLoaded = true;

      notifyListeners();
    }
  }

  void changedSeatMap() async {
    isLoaded = false;
    if (!isLoaded) {
      seatChanged = await RegularTicketService.changedSeatMap(reqSeatMap);

      if (seatChanged.isNotEmpty) {
        // bookDetail = await RegularTicketService.getBookingDetail(reqSeatMap["booking_code"]);
        bookingInfo = await RegularTicketService.getBookingInfo(reqSeatMap["booking_code"]);

        if (context != null) {
          // await Navigator.pushNamed(context!, SelectedPaymentPage.routeName, arguments: SelectedPaymentArguments(args!.schedule, args!.bookingCart, args!.bookingCode, args!.transactionId));
        }
      }

      isLoaded = true;
      notifyListeners();
    }
  }

  void selectSeatButton() async {
    await Navigator.pushNamed(context!, SelectSeatPage.routeName);
  }

  List<String> updateArray(List<String> array, String addToStartOfArray) {
    return array
      ..insert(0, addToStartOfArray)
      ..removeLast();
  }
}
