import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/booking_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingTicketPage extends StatefulWidget {
  static const routeName = '/booking-ticket-pages';

  const BookingTicketPage({Key? key}) : super(key: key);

  @override
  State<BookingTicketPage> createState() => _BookingTicketPageState();
}

class _BookingTicketPageState extends State<BookingTicketPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  BookingState state = BookingState();

  bool isEmailValid = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Widget tileDivider({double height = 22}) {
    return Divider(
      height: height,
      thickness: .25,
      color: KaiColor.black,
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
          value: state.isTicketFlexible,
          onChanged: (bool? value) {
            state.setTicketFlexible(value!);
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

  @override
  Widget build(BuildContext context) {
    state = Provider.of<BookingState>(context);
    state.initState(context, scaffoldKey);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: KaiColor.white,
            size: 40.0,
          ),
          onPressed: () => state.onBackButton(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(
          'Trains',
          style: KaiTextStyle.titleSmallBold.apply(color: KaiColor.white),
        ),
        backgroundColor: KaiColor.blue,
        centerTitle: true,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],
      ),
      body: Container(
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
                    buildActionTile(
                      'From',
                      'Select origin city/station',
                      'assets/images/ic_train_black.png',
                    ),
                    tileDivider(),
                    buildActionTile(
                      'To',
                      'Select destination city/station ',
                      'assets/images/ic_train_black.png',
                    ),
                  ],
                )
              ],
            ),
            tileDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildActionTile(
                  'Departure Date',
                  'Friday, 28 May 2021',
                  'assets/images/ic_calendar_arrow.png',
                  subtitlePadding: 16,
                ),
                Switch(
                  value: state.isRoundTrip,
                  onChanged: (bool value) => state.setRoundTrip(value),
                )
              ],
            ),
            tileDivider(),
            Visibility(
              visible: state.isRoundTrip,
              child: Column(
                children: [
                  buildActionTile(
                    'Return Date',
                    'Friday, 28 May 2021',
                    'assets/images/ic_calendar_arrow_left.png',
                    subtitlePadding: 16,
                  ),
                  tileDivider(),
                ],
              ),
            ),
            Row(
              children: [
                buildActionTile(
                  'Passenggers',
                  '1 Adult',
                  'assets/images/ic_passenger.png',
                  subtitlePadding: 12,
                ),
                const SizedBox(width: 16),
                buildActionTile(
                  'Seat Class',
                  'Bussiness',
                  'assets/images/ic_seat.png',
                  subtitlePadding: 12,
                ),
              ],
            ),
            const SizedBox(height: 12),
            tileDivider(height: 0),
            buildFlexibleTicket(),
            KaiButton(
              text: 'Search',
              // onClick: () => state.onSearchButton(),
              onClick: () => buildPassengerBottomSheet(context, state),
              buttonColor: KaiColor.yellow,
              textColor: KaiColor.white,
              sideColor: KaiColor.yellow,
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> buildPassengerBottomSheet(
  BuildContext context,
  BookingState state,
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

Future<dynamic> buildPickDateBottomSheet(
  BuildContext context,
  BookingState state,
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
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: KaiColor.blue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          alignment: Alignment.center,
                          child: Text(
                            'Select Date',
                            style: KaiTextStyle.titleSmallBold.apply(
                              color: KaiColor.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: KaiColor.white,
                          ),
                          onPressed: () => Navigator.of(_context).pop(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SfDateRangePicker(
                allowViewNavigation: false,
                minDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  01,
                ),
                maxDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  31,
                ),
              ),
              SfDateRangePicker(
                allowViewNavigation: false,
                minDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month + 1,
                  01,
                ),
                maxDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month + 1,
                  31,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<dynamic> buildSeatClassBottomSheet(
  BuildContext context,
  BookingState state,
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
                'CHOOSE YOUR SEAT CLASS',
                style: KaiTextStyle.titleSmallBold,
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 0,
                thickness: .25,
                color: KaiColor.black,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Image(
                        image: AssetImage('assets/images/selected_option.png'),
                        height: 16,
                        width: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Economy',
                            style: KaiTextStyle.labelRegular,
                          ),
                          Text(
                            'Fly at the lowest cost, with all your basic needs covered.',
                            style: KaiTextStyle.smallThin,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Image(
                        image:
                            AssetImage('assets/images/unselected_option.png'),
                        height: 16,
                        width: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Premium Economy',
                            style: KaiTextStyle.labelRegular,
                          ),
                          Text(
                            'An affordable way to fly, with tasty meal and bigger legroom..',
                            style: KaiTextStyle.smallThin,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Image(
                        image:
                            AssetImage('assets/images/unselected_option.png'),
                        height: 16,
                        width: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Business',
                            style: KaiTextStyle.labelRegular,
                          ),
                          Text(
                            'Fly in style, with exclusive check-in counters and seating..',
                            style: KaiTextStyle.smallThin,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Image(
                        image:
                            AssetImage('assets/images/unselected_option.png'),
                        height: 16,
                        width: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'First Business',
                            style: KaiTextStyle.labelRegular,
                          ),
                          Text(
                            'The most luxurious class, with personalized five-star services..',
                            style: KaiTextStyle.smallThin,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              KaiButton(
                text: 'Done',
                onClick: () {
                  Navigator.of(_context).pop();

                  state.onSearchButton();
                },
                buttonColor: KaiColor.blue,
                textColor: KaiColor.white,
                sideColor: KaiColor.blue,
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      );
    },
  );
}
