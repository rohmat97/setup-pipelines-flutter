import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/providers/regular_ticket_state.dart';
import 'package:kai_wisata/kai_reguler/widgets/search_station.dart';
import 'package:kai_wisata/kai_reguler/widgets/seat_class.dart';
import 'package:kai_wisata/kai_reguler/widgets/seat_qty.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';
import 'package:kai_wisata/kai_reguler/widgets/kai_last_search.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../../data/models/station.dart';

class RegularTicketPage extends StatefulWidget {
  static const routeName = '/regular-ticket-pages';

  const RegularTicketPage({Key? key}) : super(key: key);

  @override
  State<RegularTicketPage> createState() => _RegularTicketPageState();
}

class _RegularTicketPageState extends State<RegularTicketPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  RegularTicketState? state;

  @override
  initState() {
    super.initState();
  }

  bool isEmailValid = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  Widget tileDivider({double height = 22}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Divider(
        height: height,
        thickness: .25,
        color: KaiColor.black,
      ),
    );
  }

  Widget buildActionTile(String title, String contentText, String icon,
      {double subtitlePadding = 10}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: KaiTextStyle.smallBold.apply(color: KaiColor.black),
          ),
          const SizedBox(height: 6.35),
          Row(
            children: [
              Image(image: AssetImage(icon)),
              SizedBox(width: subtitlePadding),
              Text(
                contentText,
                style: KaiTextStyle.smallThin.apply(color: KaiColor.black),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildNewTile(String title, String contentText, String icon,
      {Function? onTap, double subtitlePadding = 10}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: KaiTextStyle.smallBold.apply(
              color: KaiColor.black,
              fontSizeDelta: 3.0,
            ),
          ),
          const SizedBox(height: 6.35),
          Row(
            children: [
              SvgPicture.asset(icon, height: 20),
              SizedBox(width: subtitlePadding),
              Text(
                contentText,
                style: KaiTextStyle.bodySmallMedium.apply(
                  color: KaiColor.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFlexibleTicket() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Row(
      children: [
        Checkbox(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: state?.isTicketFlexible,
          onChanged: (bool? value) {
            state?.setTicketFlexible(value!);
          },
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            'Include flexible tickets',
            style: KaiTextStyle.smallThin.apply(color: KaiColor.black),
          ),
        ),
        const Image(image: AssetImage('assets/images/ic_info.png')),
        const SizedBox(width: 18),
      ],
    );
  }

  void onPickFromStation(Station station) {
    state?.setFromStation(station);
    Navigator.of(context).pop();
  }

  void onPickToStation(Station station) {
    state?.setToStation(station);
    Navigator.of(context).pop();
  }

  Future<dynamic> buildPickStationSheet(BuildContext context,
      RegularTicketState state, Function(Station) onPick) async {
    await state.fetchStations();

    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SearchStation(state.fromStations, onPick);
          },
        );
      },
    );
  }

    DateTime getFirstDate() {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

  DateTime getLastDate() {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month + 3,
      DateTime.now().day + 1,
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: state?.fromDate ?? DateTime.now(),
        firstDate: getFirstDate(),
        lastDate: getLastDate());

    if (picked != null && picked != state?.fromDate) {
      state?.setFromDate(picked);
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: state?.toDate ?? DateTime.now(),
        firstDate: getFirstDate(),
        lastDate: getLastDate());

    if (picked != null && picked != state?.toDate) {
      state?.setToDate(picked);
    }
  }

  Future<dynamic> buildSeatBottomSheet(
    BuildContext context,
    RegularTicketState state,
  ) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SeatQty(
                state.seat,
                (seat) => {
                      setModalState(() => {state.setSeat(seat)})
                    });
          },
        );
      },
    );
  }

  void showError(String message) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
          color: KaiColor.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: SvgPicture.asset(
                'assets/svg/bar_line.svg',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: Colors.red),
                  ),
                ),
                KaiButton(
                  text: 'Try again',
                  onClick: () => Navigator.pop(context),
                  buttonColor: KaiColor.blue,
                  textColor: KaiColor.white,
                  sideColor: KaiColor.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<RegularTicketState>(context);
    state?.initState(context, scaffoldKey);
    state?.fetchHistories();

    return Scaffold(
      backgroundColor: KaiColor.neutral11,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: KaiColor.white,
                child: Row(
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
                        onTap: () => state?.onBackButton(),
                      ),
                    ),
                    Text(
                      'Kereta Api Regular',
                      style: KaiTextStyle.titleSmallBold
                          .apply(color: KaiColor.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  child: Text(
                    'Mau pergi ke\nmana kali ini?',
                    style: KaiTextStyle.bodyLargeBold.apply(
                      color: KaiColor.dark900,
                      fontSizeDelta: 8.0,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: KaiColor.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 13),
                            InkWell(
                              onTap: () => buildPickStationSheet(
                                  context, state!, onPickFromStation),
                              child: buildNewTile(
                                'Dari',
                                "${state?.getFromStation()}",
                                'assets/svg/train.svg',
                              ),
                            ),
                            tileDivider(),
                            InkWell(
                              onTap: () => buildPickStationSheet(
                                  context, state!, onPickToStation),
                              child: buildNewTile(
                                'Ke',
                                "${state?.getToStation()}",
                                'assets/svg/train.svg',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    tileDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => _selectFromDate(context),
                          child: buildNewTile(
                            'Tanggal Pergi',
                            "${state?.getFromDate()}",
                            'assets/svg/calendar_blue.svg',
                            subtitlePadding: 16,
                          ),
                        ),
                        Column(
                          children: [
                            Switch(
                              value: state!.isRoundTrip,
                              onChanged: (bool value) =>
                                  state?.setRoundTrip(value),
                            ),
                          ],
                        )
                      ],
                    ),
                    tileDivider(),
                    Visibility(
                      visible: state!.isRoundTrip,
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () => _selectToDate(context),
                              child: buildNewTile(
                                'Tanggal Pulang',
                                "${state?.getToDate()}",
                                'assets/svg/calendar_blue.svg',
                                subtitlePadding: 16,
                              )),
                          tileDivider(),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () => buildSeatBottomSheet(context, state!),
                            child: buildNewTile(
                              'Jumlah Kursi',
                              '${state?.seat} Adult',
                              'assets/svg/train.svg',
                              subtitlePadding: 12,
                            )),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Penumpang bayi tidak mendapatkan kursi sendiri',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    KaiButton(
                      text: 'Cari Tiket',
                      onClick: () {
                        List<dynamic> error = state!.checkError();

                        print(error);
                        if (error[0]) {
                          showError(error[1]);
                        } else {
                          buildPassengerBottomSheet(context, state!);
                        }
                      },
                      buttonColor: state!.isValid ? KaiColor.blue : Colors.grey,
                      textColor: KaiColor.white,
                      sideColor: state!.isValid ? KaiColor.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pencarian Terakhir Anda',
                    style: KaiTextStyle.bodyLargeBold.apply(
                      fontSizeDelta: -1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state!.histories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return KaiLastSearch(
                        state!.histories[index],
                        onTap: () => state!.onSearch(state!.histories[index]),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> buildPassengerBottomSheet(
  BuildContext context,
  RegularTicketState state,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (_context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 28),
              const Text(
                'Add Passenger',
                style: KaiTextStyle.titleSmallBold,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: MediaQuery.of(_context).size.width / 2,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: KaiColor.black,
                              width: .5,
                            ),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Text('Adult', style: KaiTextStyle.smallBold),
                            Text('Age 2+', style: KaiTextStyle.smallThin),
                          ],
                        ),
                      ),
                      NumberPicker(
                        value: state.adultTicketCount,
                        minValue: 1,
                        maxValue: 4,
                        itemHeight: 32,
                        itemWidth: MediaQuery.of(_context).size.width / 2,
                        textStyle: KaiTextStyle.labelRegular
                            .apply(color: KaiColor.blue),
                        selectedTextStyle: KaiTextStyle.labelRegular.apply(
                          color: KaiColor.blue,
                        ),
                        decoration: BoxDecoration(
                          color: KaiColor.grey.withOpacity(.15),
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            state.setAdultTicketCount(value);
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: MediaQuery.of(_context).size.width / 3,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: KaiColor.black,
                              width: .5,
                            ),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Text('Infant', style: KaiTextStyle.smallBold),
                            Text('Below age 2', style: KaiTextStyle.smallThin),
                          ],
                        ),
                      ),
                      NumberPicker(
                        value: state.infantTicketCount,
                        minValue: 0,
                        maxValue: 2,
                        itemHeight: 32,
                        itemWidth: MediaQuery.of(_context).size.width / 3,
                        textStyle: KaiTextStyle.labelRegular
                            .apply(color: KaiColor.blue),
                        selectedTextStyle: KaiTextStyle.labelRegular.apply(
                          color: KaiColor.blue,
                        ),
                        decoration: BoxDecoration(
                          color: KaiColor.grey.withOpacity(.15),
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            state.setInfantTicketCount(value);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // const SizedBox(width: 18),
                  KaiCustomButton(
                    text: 'Cancel',
                    onClick: () {
                      Navigator.of(_context).pop();
                    },
                    buttonColor: KaiColor.blue.withOpacity(0.1),
                    textColor: KaiColor.blue,
                    sideColor: KaiColor.blue.withOpacity(0.1),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 40,
                  ),
                  KaiCustomButton(
                    text: 'Select',
                    onClick: () {
                      Navigator.of(_context).pop();
                      state.onSearchButton();
                    },
                    buttonColor: KaiColor.blue,
                    textColor: KaiColor.white,
                    sideColor: KaiColor.blue,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 40,
                  ),
                ],
              ),
              const SizedBox(height: 48),
            ],
          );
        },
      );
    },
  );
}

Future<dynamic> buildSeatClassBottomSheet(
  BuildContext context,
  RegularTicketState state,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (_context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return SeatClass(state.seatClass, (kelass) {
            setModalState(() => {state.setSeatClass(kelass)});

            state.onSearchButton();
          });
        },
      );
    },
  );
}
