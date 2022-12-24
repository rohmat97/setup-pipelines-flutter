import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/hex_color.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/arguments/select_seat_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/selected_payment_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';
import 'package:kai_wisata/kai_reguler/models/seats/list_seats_map.dart';
import 'package:kai_wisata/kai_reguler/models/seats/seat_map.dart';
import 'package:kai_wisata/kai_reguler/models/seats/seats_map.dart';
import 'package:kai_wisata/kai_reguler/pages/05selected_payment_page.dart';
import 'package:kai_wisata/kai_reguler/providers/select_seat_state.dart';
import 'package:kai_wisata/kai_reguler/widgets/seat_passenger_card.dart';
import 'package:kai_wisata/widgets/kai_list_wagon_button.dart';
import 'package:provider/provider.dart';
import "package:collection/collection.dart";

class SelectSeatPage extends StatefulWidget {
  static const routeName = '/regular-select-seat-pages';

  const SelectSeatPage({Key? key}) : super(key: key);

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SelectSeatState state = SelectSeatState();
  RailBookingInfo? bookingInfo;
  List<RailTicket> tickets = [];

  SeatMap? seatMap;

  String seatClass = '';
  String selSeatClass = '';

  final _formKey = GlobalKey<FormState>();

  int defIndex = 0;
  int selIndex = 0;
  
  int selWagonIndex = 0;
  int selWagonNum = 0;

  Map<String, dynamic> selWagonMap = {};

  bool isSelected = false;
  bool isLoaded = false;

  bool isSeatSelected = false;

  Color choosedColor = Colors.white;
  Color choosedSeatColor = HexColor("F38422");

  List<String> listSeatEmptyClass = ['Choose One'];
  String dropdownEmptyValue = 'Choose One';

  List<String> listSeatClass = [];
  // String? dropdownValue;
  int? dropdownValue;

  List<dynamic> seats = [];
  List<ListSeatsMap> newSeats = [];
  List<Map<int, dynamic>> newDataSeats = [];
  List<Map<int, dynamic>> newIntSeats = [];

  Map<String, dynamic> selSeatMap = {};
  Map<String, dynamic> chSeatMap = {};

  List<String> listWagonCode = [];
  List<String> listWagonNum = [];
  List<String> listSeatNumber = [];

  Map<String, dynamic> resChSeat = {};

  Widget tileDivider({double height = 22}) {
    return Divider(
      height: height,
      thickness: .25,
      color: KaiColor.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as SelectSeatArguments;
    state = Provider.of<SelectSeatState>(context);
    bookingInfo = args.bookingInfo;
    state.getSeatMap(bookingInfo!.gdsBookCode);

    if (state.bookingInfo != null) {
      if (state.bookingInfo!.routeInfo.isNotEmpty) {
        for (var sri in state.bookingInfo!.routeInfo) {
          tickets = sri.tickets;
        }
      } else {
        for (var ri in bookingInfo!.routeInfo) {
          tickets = ri.tickets;
        }
      }
    } else {
      for (var ri in bookingInfo!.routeInfo) {
        tickets = ri.tickets;
      }
    }

    if (state.isLoaded) {
      seatMap = state.seatMap;
      for (var i = 0; i < seatMap?.data?["seat_map"].length; i++) {
        for (var x = 0; x < seatMap?.data?["seat_map"][i].length; x++) {
          if (seatMap?.data?["seat_map"][i][x] == 'EKO') {
            selSeatClass = 'Ekonomi ${seatMap?.data?["seat_map"][i][1]}';
          }
          if (seatMap?.data?["seat_map"][i][x] == 'BIS') {
            selSeatClass = 'Bisnis ${seatMap?.data?["seat_map"][i][1]}';
          }
          if (seatMap?.data?["seat_map"][i][x] == 'EKS') {
            selSeatClass = 'Eksekutif ${seatMap?.data?["seat_map"][i][1]}';
          }
        }
        if (!listSeatClass.contains(selSeatClass)) {
          listSeatClass.add(selSeatClass);
        }
        if (selWagonIndex == 0) {
          if (seats.isEmpty) {
            // print(seatMap?.data?["seat_map"][i][2]);
            seats.addAll(seatMap?.data?["seat_map"][i]);
            selWagonNum = seats[1];
          }
        }
      }
    }

    if (seats.isNotEmpty) {
      seats = seatMap?.data?["seat_map"].elementAt(selWagonIndex);
      selWagonNum = seats[1];
      for (var ss = 0; ss < seats[2].length; ss++) {
        List<SeatsMap> nested = [];
        newSeats.add(ListSeatsMap.fromJson({
          "columns": seats[2][ss][0],
          "data_seats": [],
        }));
        nested.add(SeatsMap.fromJson({
          "columns": seats[2][ss][0],
          "rows_seats": seats[2][ss][1],
          "column_seats": seats[2][ss][2],
          "aplha_seats": seats[2][ss][3],
          "class_seats": seats[2][ss][4],
          "filled_seats": seats[2][ss][5] != '' ? seats[2][ss][5] : 0,
        }));
        if (newSeats[ss].columns == seats[2][ss][0]) {
          // nested.add(SeatsMap.fromJson({
          //   "columns": seats[2][ss][0],
          //   "rows_seats": seats[2][ss][1],
          //   "column_seats": seats[2][ss][2],
          //   "aplha_seats": seats[2][ss][3],
          //   "class_seats": seats[2][ss][4],
          //   "filled_seats": seats[2][ss][5] != '' ? seats[2][ss][5] : 0,
          // }));
          // newSeats[ss].dataSeats?.add(SeatsMap.fromJson({
          //   "columns": seats[2][ss][0],
          //   "rows_seats": seats[2][ss][1],
          //   "column_seats": seats[2][ss][2],
          //   "aplha_seats": seats[2][ss][3],
          //   "class_seats": seats[2][ss][4],
          //   "filled_seats": seats[2][ss][5] != '' ? seats[2][ss][5] : 0,
          // }));
        }
        newSeats[ss].dataSeats?.add(SeatsMap.fromJson(nested[0].toJson()));
      }
    }

    return Scaffold(
      backgroundColor: KaiColor.neutral11,
      body: ListView(
        children: [
          SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: KaiColor.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  ),
                                  onTap: () => state.onBackButton(),
                                ),
                              ),
                              Text(
                                "Pilih Kursi",
                                style: KaiTextStyle.titleSmallBold.apply(color: KaiColor.black),
                              ),
                            ],
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, SelectedPaymentPage.routeName, arguments: SelectedPaymentArguments(args.schedule, args.bookingCart, args.bookingCode, args.transactionId));
                            },
                            child: const Text('Lanjut'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: tickets.asMap().map((i, tc) {
                            setState(() {
                              defIndex = i;
                            });

                            var classes = tc.seat.split('/');
                            var wagonNum = classes[0].split('-');
                            if (classes[0].contains('EKO')) {
                              seatClass = 'Ekonomi ${wagonNum[1]}';
                            }
                            if (classes[0].contains('BIS')) {
                              seatClass = 'Bisnis ${wagonNum[1]}';
                            }
                            if (classes[0].contains('EKS')) {
                              seatClass = 'Eksekutif ${wagonNum[1]}';
                            }

                            if (defIndex == 0) {
                              choosedColor = HexColor("FEF0D3");
                            } else {
                              choosedColor = Colors.white;
                            }

                            if (listWagonCode.isEmpty && listWagonCode.length < tickets.length) {
                              listWagonCode.add(wagonNum[0]);
                            }

                            if (listWagonNum.isEmpty && listWagonNum.length < tickets.length) {
                              listWagonNum.add(wagonNum[1]);
                            }

                            if (listSeatNumber.isEmpty && listSeatNumber.length < tickets.length) {
                              listSeatNumber.add(classes[1]);
                            }
                            
                            return MapEntry(i,
                              SeatPassengerCard(
                                name: tc.name,
                                seatClass: seatClass,
                                seatNum: classes[1],
                                onTap: () async {
                                  setState(() {
                                    selIndex = i;
                                  });
                                },
                                color: selIndex == i ? HexColor("FEF0D3") : Colors.white,
                              ),
                            );
                          }).values.toList(),
                        ),
                      ),
                    ),
                    tileDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: KaiColor.neutral11,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: HexColor("F38422"),
                                    width: 1,
                                  ),
                                ),
                              ),
                              const Text(
                                'Tersedia',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: HexColor("F38422"),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: HexColor("F38422"),
                                    width: 1,
                                  ),
                                ),
                              ),
                              const Text(
                                'Dipilih',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: HexColor("D9D9D9"),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: HexColor("D9D9D9"),
                                    width: 1,
                                  ),
                                ),
                              ),
                              const Text(
                                'Terisi',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    state.isLoaded ? Center(
                      child: DropdownButton(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (int? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            // selWagonIndex = index;
                            dropdownValue = value!;
                            selWagonIndex = dropdownValue!;
                          });
                        },
                        items: listSeatClass.asMap().map((i, String value) {
                          return MapEntry(i, DropdownMenuItem(
                            value: i,
                            child: Text(value),
                          ));
                        }).values.toList(),
                      ),
                    ) : Center(
                      child: KaiListWagonButton(
                        text: const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Select',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              WidgetSpan(child: Icon(Icons.expand_more_rounded)),
                            ],
                          ),
                        ),
                        onClick: () async {},
                        buttonColor: KaiColor.blue,
                        textColor: KaiColor.white,
                        sideColor: KaiColor.blue,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 44,
                      ),
                    ),
                    state.isLoaded ? Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 32),
                        width: MediaQuery.of(context).size.width,
                        // child: MediaQuery.removePadding(
                        //   context: context,
                        //   removeTop: true,
                        //   child: GridView.count(
                        //       crossAxisCount: 3,
                        //       crossAxisSpacing: 4.0,
                        //       mainAxisSpacing: 8.0,
                        //       children: List.generate(seats[2].length, (index) {
                        //         return Center(
                        //           child: Text('lala'),
                        //         );  
                        //       }  
                        //     )  
                        //   ),
                        // ),
                        child: Wrap(
                          runSpacing: 10,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: selWagonNum == seats[1] && seats[2][0][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][0][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][0][0],
                                                    "alphabets": seats[2][0][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][0][0]}${seats[2][0][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][1][0]}${seats[2][0][3]}' ? choosedSeatColor : (seats[2][0][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][0][0]}${seats[2][0][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: selWagonNum == seats[1] && seats[2][1][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][1][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][1][0],
                                                    "alphabets": seats[2][1][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][1][0]}${seats[2][1][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][1][0]}${seats[2][1][3]}' ? choosedSeatColor : (seats[2][1][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][1][0]}${seats[2][1][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: selWagonNum == seats[1] && seats[2][2][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][2][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][2][0],
                                                    "alphabets": seats[2][2][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][2][0]}${seats[2][2][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][2][0]}${seats[2][2][3]}' ? choosedSeatColor : (seats[2][2][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][2][0]}${seats[2][2][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: null,
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: HexColor('D9D9D9'),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('X'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][3][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][3][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][3][0],
                                                    "alphabets": seats[2][3][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][3][0]}${seats[2][3][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][3][0]}${seats[2][3][3]}' ? choosedSeatColor : (seats[2][3][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][3][0]}${seats[2][3][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][4][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][4][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][4][0],
                                                    "alphabets": seats[2][4][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][4][0]}${seats[2][4][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][4][0]}${seats[2][4][3]}' ? choosedSeatColor : (seats[2][4][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][4][0]}${seats[2][4][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][5][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][5][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][5][0],
                                                    "alphabets": seats[2][5][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][5][0]}${seats[2][5][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][5][0]}${seats[2][5][3]}' ? choosedSeatColor : (seats[2][5][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][5][0]}${seats[2][5][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][6][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][6][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][6][0],
                                                    "alphabets": seats[2][6][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][6][0]}${seats[2][6][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][6][0]}${seats[2][6][3]}' ? choosedSeatColor : (seats[2][6][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][6][0]}${seats[2][6][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][7][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][7][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][7][0],
                                                    "alphabets": seats[2][7][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][7][0]}${seats[2][7][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][7][0]}${seats[2][7][3]}' ? choosedSeatColor : (seats[2][7][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][7][0]}${seats[2][7][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][8][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][8][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][8][0],
                                                    "alphabets": seats[2][8][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][8][0]}${seats[2][8][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][8][0]}${seats[2][8][3]}' ? choosedSeatColor : (seats[2][8][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][8][0]}${seats[2][8][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][9][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][9][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][9][0],
                                                    "alphabets": seats[2][9][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][9][0]}${seats[2][9][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][9][0]}${seats[2][9][3]}' ? choosedSeatColor : (seats[2][9][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][9][0]}${seats[2][9][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][10][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][10][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][10][0],
                                                    "alphabets": seats[2][10][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][10][0]}${seats[2][10][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][10][0]}${seats[2][10][3]}' ? choosedSeatColor : (seats[2][10][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][10][0]}${seats[2][10][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][11][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][11][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][11][0],
                                                    "alphabets": seats[2][11][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][11][0]}${seats[2][11][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][11][0]}${seats[2][11][3]}' ? choosedSeatColor : (seats[2][11][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][11][0]}${seats[2][11][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][12][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][12][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][12][0],
                                                    "alphabets": seats[2][12][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][12][0]}${seats[2][12][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][12][0]}${seats[2][12][3]}' ? choosedSeatColor : (seats[2][12][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][12][0]}${seats[2][12][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][13][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][13][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][13][0],
                                                    "alphabets": seats[2][13][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][13][0]}${seats[2][13][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][13][0]}${seats[2][13][3]}' ? choosedSeatColor : (seats[2][13][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][13][0]}${seats[2][13][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][14][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][14][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][14][0],
                                                    "alphabets": seats[2][14][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][14][0]}${seats[2][14][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][14][0]}${seats[2][14][3]}' ? choosedSeatColor : (seats[2][14][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][14][0]}${seats[2][14][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][15][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][15][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][15][0],
                                                    "alphabets": seats[2][15][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][15][0]}${seats[2][15][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][15][0]}${seats[2][15][3]}' ? choosedSeatColor : (seats[2][15][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][15][0]}${seats[2][15][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][16][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][16][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][16][0],
                                                    "alphabets": seats[2][16][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][16][0]}${seats[2][16][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][16][0]}${seats[2][16][3]}' ? choosedSeatColor : (seats[2][16][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][16][0]}${seats[2][16][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][17][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][17][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][17][0],
                                                    "alphabets": seats[2][17][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][17][0]}${seats[2][17][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][17][0]}${seats[2][17][3]}' ? choosedSeatColor : (seats[2][17][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][17][0]}${seats[2][17][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][18][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][18][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][18][0],
                                                    "alphabets": seats[2][18][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][18][0]}${seats[2][18][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][18][0]}${seats[2][18][3]}' ? choosedSeatColor : (seats[2][18][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][18][0]}${seats[2][18][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][19][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][19][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][19][0],
                                                    "alphabets": seats[2][19][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][19][0]}${seats[2][19][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][19][0]}${seats[2][19][3]}' ? choosedSeatColor : (seats[2][19][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][19][0]}${seats[2][19][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][20][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][20][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][20][0],
                                                    "alphabets": seats[2][20][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][20][0]}${seats[2][20][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][20][0]}${seats[2][20][3]}' ? choosedSeatColor : (seats[2][20][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][20][0]}${seats[2][20][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][21][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][21][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][21][0],
                                                    "alphabets": seats[2][21][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][21][0]}${seats[2][21][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][21][0]}${seats[2][21][3]}' ? choosedSeatColor : (seats[2][21][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][21][0]}${seats[2][21][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][22][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][22][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][22][0],
                                                    "alphabets": seats[2][22][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][22][0]}${seats[2][22][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][22][0]}${seats[2][22][3]}' ? choosedSeatColor : (seats[2][22][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][22][0]}${seats[2][22][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][23][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][23][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][23][0],
                                                    "alphabets": seats[2][23][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][23][0]}${seats[2][23][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][23][0]}${seats[2][23][3]}' ? choosedSeatColor : (seats[2][23][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][23][0]}${seats[2][23][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][24][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][24][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][24][0],
                                                    "alphabets": seats[2][24][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][24][0]}${seats[2][24][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][24][0]}${seats[2][24][3]}' ? choosedSeatColor : (seats[2][24][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][24][0]}${seats[2][24][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][25][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][25][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][25][0],
                                                    "alphabets": seats[2][25][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][25][0]}${seats[2][25][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][25][0]}${seats[2][25][3]}' ? choosedSeatColor : (seats[2][25][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][25][0]}${seats[2][25][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][26][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][26][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][26][0],
                                                    "alphabets": seats[2][26][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][26][0]}${seats[2][26][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][26][0]}${seats[2][26][3]}' ? choosedSeatColor : (seats[2][26][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][26][0]}${seats[2][26][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][27][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][27][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][27][0],
                                                    "alphabets": seats[2][27][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][27][0]}${seats[2][27][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][27][0]}${seats[2][27][3]}' ? choosedSeatColor : (seats[2][27][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][27][0]}${seats[2][27][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][28][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][28][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][28][0],
                                                    "alphabets": seats[2][28][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][28][0]}${seats[2][28][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][28][0]}${seats[2][28][3]}' ? choosedSeatColor : (seats[2][28][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][28][0]}${seats[2][28][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][29][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][29][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][29][0],
                                                    "alphabets": seats[2][29][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][29][0]}${seats[2][29][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][29][0]}${seats[2][29][3]}' ? choosedSeatColor : (seats[2][29][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][29][0]}${seats[2][29][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][30][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][30][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][30][0],
                                                    "alphabets": seats[2][30][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][30][0]}${seats[2][30][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][30][0]}${seats[2][30][3]}' ? choosedSeatColor : (seats[2][30][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][30][0]}${seats[2][30][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][31][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][31][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][31][0],
                                                    "alphabets": seats[2][31][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][31][0]}${seats[2][31][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][31][0]}${seats[2][31][3]}' ? choosedSeatColor : (seats[2][31][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][31][0]}${seats[2][31][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][32][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][32][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][32][0],
                                                    "alphabets": seats[2][32][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][32][0]}${seats[2][32][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][32][0]}${seats[2][32][3]}' ? choosedSeatColor : (seats[2][32][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][32][0]}${seats[2][32][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][33][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][33][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][33][0],
                                                    "alphabets": seats[2][33][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][33][0]}${seats[2][33][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][33][0]}${seats[2][33][3]}' ? choosedSeatColor : (seats[2][33][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][33][0]}${seats[2][33][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][34][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][34][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][34][0],
                                                    "alphabets": seats[2][34][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][34][0]}${seats[2][34][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][34][0]}${seats[2][34][3]}' ? choosedSeatColor : (seats[2][34][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][34][0]}${seats[2][34][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][35][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][35][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][35][0],
                                                    "alphabets": seats[2][35][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][35][0]}${seats[2][35][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][35][0]}${seats[2][35][3]}' ? choosedSeatColor : (seats[2][35][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][35][0]}${seats[2][35][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][36][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][36][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][36][0],
                                                    "alphabets": seats[2][36][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][36][0]}${seats[2][36][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][35][0]}${seats[2][35][3]}' ? choosedSeatColor : (seats[2][35][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][36][0]}${seats[2][36][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][37][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][37][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][37][0],
                                                    "alphabets": seats[2][37][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][37][0]}${seats[2][37][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][37][0]}${seats[2][37][3]}' ? choosedSeatColor : (seats[2][37][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][37][0]}${seats[2][37][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][38][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][38][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][38][0],
                                                    "alphabets": seats[2][38][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][38][0]}${seats[2][38][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][38][0]}${seats[2][38][3]}' ? choosedSeatColor : (seats[2][38][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][38][0]}${seats[2][38][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][39][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][39][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][39][0],
                                                    "alphabets": seats[2][39][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][39][0]}${seats[2][39][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][39][0]}${seats[2][39][3]}' ? choosedSeatColor : (seats[2][39][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][39][0]}${seats[2][39][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][40][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][40][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][40][0],
                                                    "alphabets": seats[2][40][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][40][0]}${seats[2][40][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][40][0]}${seats[2][40][3]}' ? choosedSeatColor : (seats[2][40][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][40][0]}${seats[2][40][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][41][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][41][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][41][0],
                                                    "alphabets": seats[2][41][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][41][0]}${seats[2][41][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][41][0]}${seats[2][41][3]}' ? choosedSeatColor : (seats[2][41][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][41][0]}${seats[2][41][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][42][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][42][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][42][0],
                                                    "alphabets": seats[2][42][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][42][0]}${seats[2][42][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][42][0]}${seats[2][42][3]}' ? choosedSeatColor : (seats[2][42][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][42][0]}${seats[2][42][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][43][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][43][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][43][0],
                                                    "alphabets": seats[2][43][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][43][0]}${seats[2][43][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][43][0]}${seats[2][43][3]}' ? choosedSeatColor : (seats[2][43][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][43][0]}${seats[2][43][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][44][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][44][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][44][0],
                                                    "alphabets": seats[2][44][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][44][0]}${seats[2][44][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][44][0]}${seats[2][44][3]}' ? choosedSeatColor : (seats[2][44][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][44][0]}${seats[2][44][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][45][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][45][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][45][0],
                                                    "alphabets": seats[2][45][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][45][0]}${seats[2][45][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][45][0]}${seats[2][45][3]}' ? choosedSeatColor : (seats[2][45][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][45][0]}${seats[2][45][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][46][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][46][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][46][0],
                                                    "alphabets": seats[2][46][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][46][0]}${seats[2][46][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][46][0]}${seats[2][46][3]}' ? choosedSeatColor : (seats[2][46][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][46][0]}${seats[2][46][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][47][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][47][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][47][0],
                                                    "alphabets": seats[2][47][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][47][0]}${seats[2][47][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][47][0]}${seats[2][47][3]}' ? choosedSeatColor : (seats[2][47][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][47][0]}${seats[2][47][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: seats[2][48][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][48][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][48][0],
                                                    "alphabets": seats[2][48][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][48][0]}${seats[2][48][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][48][0]}${seats[2][48][3]}' ? choosedSeatColor : (seats[2][48][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][48][0]}${seats[2][48][3]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: seats[2][49][5] == 1 ? null : () {
                                              if (selWagonNum == seats[1] && seats[2][49][5] != 1) {
                                                setState(() {
                                                  selSeatMap.addAll({
                                                    "booking_code": args.bookingCode,
                                                    "column": seats[2][49][0],
                                                    "alphabets": seats[2][49][3],
                                                    "filled_seat": 1,
                                                    "seat_number": '${seats[2][49][0]}${seats[2][49][3]}',
                                                    "wagon_num": seats[1],
                                                    "wagon_class": seats[0],
                                                  });
                                                });
                                                // print(selSeatMap);
                                                if (listWagonCode.length == tickets.length) {
                                                  // listWagonCode.add(selSeatMap["wagon_class"]);
                                                  // print(listWagonCode);
                                                  if (listWagonNum.isNotEmpty) {
                                                    listWagonNum.replaceRange(selIndex, defIndex + 1, [selSeatMap["wagon_num"].toString()]);
                                                    // print(listWagonNum);
                                                  }
                                                  if (listSeatNumber.isNotEmpty) {
                                                    listSeatNumber.replaceRange(selIndex, defIndex + 1, [selSeatMap["seat_number"]]);
                                                    // print(listSeatNumber);
                                                    // listSeatNumber.contains(selSeatMap["seat_number"]) ? listSeatNumber[listSeatNumber.indexWhere((v) => v == tickets[0].seat)] ;
                                                  }
                                                }
                                                state.setChangeSeatMap(selSeatMap, listWagonCode, listWagonNum, listSeatNumber);
                                                state.changedSeatMap();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: selSeatMap["wagon_num"] == seats[1] && selSeatMap["seat_number"] == '${seats[2][49][0]}${seats[2][49][3]}' ? choosedSeatColor : (seats[2][49][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('${seats[2][49][0]}${seats[2][49][3]}'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: null,
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: HexColor('D9D9D9'),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: HexColor("F38422"),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text('X'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                          // children: [
                          //   for (var ix = 0; ix < seats[2].length; ix++)
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Column(
                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Row(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                          //                 children: [
                          //                   seats[2][ix][3] == 'A' ? Container(
                          //                     margin: const EdgeInsets.only(right: 12),
                          //                     width: 16,
                          //                     height: 16,
                          //                     decoration: BoxDecoration(
                          //                       color: seats[2][ss][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11,
                          //                       borderRadius: BorderRadius.circular(5),
                          //                       border: Border.all(
                          //                         color: HexColor("F38422"),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: Text('${seats[2][ix][3]}'),
                          //                   ) : Container(),
                          //                   seats[2][ix][3] == 'B' ? Container(
                          //                     margin: const EdgeInsets.only(right: 12),
                          //                     width: 16,
                          //                     height: 16,
                          //                     decoration: BoxDecoration(
                          //                       color: seats[2][ss][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11,
                          //                       borderRadius: BorderRadius.circular(5),
                          //                       border: Border.all(
                          //                         color: HexColor("F38422"),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: Text('${seats[2][ix][3]}'),
                          //                   ) : Container(),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //         Column(
                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Row(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                          //                 children: [
                          //                   seats[2][ix][3] == 'C' ? Container(
                          //                     margin: const EdgeInsets.only(right: 12),
                          //                     width: 16,
                          //                     height: 16,
                          //                     decoration: BoxDecoration(
                          //                       color: seats[2][ss][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11,
                          //                       borderRadius: BorderRadius.circular(5),
                          //                       border: Border.all(
                          //                         color: HexColor("F38422"),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: Text('${seats[2][ix][3]}'),
                          //                   ) : Container(),
                          //                   seats[2][ix][3] == 'D' ? Container(
                          //                     margin: const EdgeInsets.only(right: 12),
                          //                     width: 16,
                          //                     height: 16,
                          //                     decoration: BoxDecoration(
                          //                       color: seats[2][ss][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11,
                          //                       borderRadius: BorderRadius.circular(5),
                          //                       border: Border.all(
                          //                         color: HexColor("F38422"),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: Text('${seats[2][ix][3]}'),
                          //                   ) : Container(),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          // ],
                          // children: [
                          //   for (var ix = 0; ix < seats[2].length; ix++)
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         seats[2][ix][3] == 'A'? Column(
                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Row(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                          //                 children: [
                          //                   Container(
                          //                     margin: const EdgeInsets.only(right: 12),
                          //                     width: 16,
                          //                     height: 16,
                          //                     decoration: BoxDecoration(
                          //                       color: seats[2][ss][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11,
                          //                       borderRadius: BorderRadius.circular(5),
                          //                       border: Border.all(
                          //                         color: HexColor("F38422"),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: Text('${seats[2][ix][3]}'),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ) : Column(),
                          //         seats[2][ix][3] == 'B'? Column(
                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Row(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                          //                 children: [
                          //                   Container(
                          //                     margin: const EdgeInsets.only(right: 12),
                          //                     width: 16,
                          //                     height: 16,
                          //                     decoration: BoxDecoration(
                          //                       color: seats[2][ss][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11,
                          //                       borderRadius: BorderRadius.circular(5),
                          //                       border: Border.all(
                          //                         color: HexColor("F38422"),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: Text('${seats[2][ix][3]}'),
                          //                   ),
                          //                   Container(
                          //                     margin: const EdgeInsets.only(right: 12),
                          //                     width: 16,
                          //                     height: 16,
                          //                     decoration: BoxDecoration(
                          //                       color: seats[2][ss][5] == 1 ? HexColor('D9D9D9') : KaiColor.neutral11,
                          //                       borderRadius: BorderRadius.circular(5),
                          //                       border: Border.all(
                          //                         color: HexColor("F38422"),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: Text('${seats[2][ix][3]}'),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ) : Column(),
                          //       ],
                          //     ),
                          // ],
                        ),
                      ),
                    ) : Center(
                      child: Container(
                        margin: EdgeInsets.zero,
                        child: Column(),
                      ),
                    ),
                    // Center(
                    //   child: KaiListWagonButton(
                    //     text: const Text.rich(
                    //       TextSpan(
                    //         children: [
                    //           TextSpan(
                    //             text: 'Select',
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.w500,
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //           WidgetSpan(child: Icon(Icons.expand_more_rounded)),
                    //         ],
                    //       ),
                    //     ),
                    //     onClick: () async {},
                    //     buttonColor: KaiColor.blue,
                    //     textColor: KaiColor.white,
                    //     sideColor: KaiColor.blue,
                    //     width: MediaQuery.of(context).size.width * 0.4,
                    //     height: 44,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}