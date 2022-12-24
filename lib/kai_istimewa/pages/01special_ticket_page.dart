import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_istimewa/providers/special_ticket_state.dart';
import 'package:kai_wisata/kai_reguler/widgets/search_station.dart';
import 'package:kai_wisata/kai_reguler/widgets/seat_class.dart';
import 'package:kai_wisata/kai_reguler/widgets/seat_qty.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../../data/models/station.dart';

class SpecialTicketPage extends StatefulWidget {
  static const routeName = '/special-ticket-pages';

  const SpecialTicketPage({Key? key}) : super(key: key);

  @override
  State<SpecialTicketPage> createState() => _SpecialTicketPageState();
}

class _SpecialTicketPageState extends State<SpecialTicketPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SpecialTicketState? state;

  @override
  initState() {
    super.initState();
  }

  bool isEmailValid = true;
  bool check1 = true;
  bool check2 = false;

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
      SpecialTicketState state, Function(Station) onPick) async {
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
      1,
    );
  }

  DateTime getLastDate() {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      31,
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
    SpecialTicketState state,
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

  @override
  Widget build(BuildContext context) {
    state = Provider.of<SpecialTicketState>(context);
    state?.initState(context, scaffoldKey);
    state?.fetchStations();

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
                      'Kereta Api Istimewa',
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
                    'Carter Kereta\nIstimewa',
                    style: KaiTextStyle.bodyLargeBold.apply(
                      color: KaiColor.black,
                      fontSizeDelta: 8.0,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20.0,
                  0.0,
                  0.0,
                  10.0,
                ),
                child: Align(
                  child: Text(
                    'Kereta khusus yang akan mengantarkan perjalananmu',
                    style: KaiTextStyle.bodyLargeMedium.apply(
                      color: KaiColor.black,
                      fontSizeDelta: -2.0,
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
                              onTap: () =>
                                  buildPickStationSheet(
                                      context, state!, onPickFromStation),
                              child: buildNewTile(
                                'Dari',
                                "${state?.getFromStation()}",
                                'assets/svg/train.svg',
                              ),
                            ),
                            tileDivider(),
                            InkWell(
                              onTap: () =>
                                  buildPickStationSheet(
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
                    const SizedBox(width: 16),
                    const SizedBox(height: 12),
                    KaiButton(
                      text: 'Cari Tiket',
                      onClick: () => state!.onNextButton(),
                      buttonColor: KaiColor.blue,
                      textColor: KaiColor.white,
                      sideColor: KaiColor.blue,
                    ),
                  ],
                ),
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
  SpecialTicketState state,
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
                        width: MediaQuery.of(_context).size.width / 3,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: KaiColor.black,
                              width: .25,
                            ),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Text('Adult', style: KaiTextStyle.smallBold),
                            Text('Age 12+', style: KaiTextStyle.smallThin),
                          ],
                        ),
                      ),
                      NumberPicker(
                        value: state.adultTicketCount,
                        minValue: 0,
                        maxValue: 100,
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
                              width: .25,
                            ),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Text('Child', style: KaiTextStyle.smallBold),
                            Text('Age 2 - 11', style: KaiTextStyle.smallThin),
                          ],
                        ),
                      ),
                      NumberPicker(
                        value: state.childTicketCount,
                        minValue: 0,
                        maxValue: 100,
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
                            state.setChildTicketCount(value);
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
                              width: .25,
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
                        maxValue: 100,
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
                      buildSeatClassBottomSheet(context, state);
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
  SpecialTicketState state,
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
