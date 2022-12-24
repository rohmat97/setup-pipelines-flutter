import 'dart:convert';
// import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:kai_wisata/flights/arguments/flight_detail_arguments.dart';
import 'package:kai_wisata/flights/caches/contact_cache.dart';
import 'package:kai_wisata/flights/models/contacts/flight_contact_model.dart';
import 'package:kai_wisata/flights/models/passengers/flight_passenger_model.dart';
import 'package:kai_wisata/flights/providers/flight_booking_state.dart';
import 'package:kai_wisata/flights/providers/flight_detail_state.dart';
import 'package:kai_wisata/flights/widgets/addon_widget.dart';
import 'package:kai_wisata/flights/widgets/booking_contact_form_widget.dart';
import 'package:kai_wisata/flights/widgets/booking_detail_card_widget.dart';
import 'package:kai_wisata/flights/widgets/booking_form_widget.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightDetailPage extends StatefulWidget {
  static const routeName = '/flight-detail-pages';

  const FlightDetailPage({Key? key}) : super(key: key);

  @override
  State<FlightDetailPage> createState() => _FlightDetailPageState();
}

class _FlightDetailPageState extends State<FlightDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  FlightDetailState state = FlightDetailState();
  FlightBookingState stateBk = FlightBookingState();
  final currencies = NumberFormat.simpleCurrency(locale: 'id_ID');

  int? seats;
  int? seatsChild;
  int? seatsInfant;

  List<BookingForm> bookingForms = [];

  double totalPrice = 0;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    // await Hive.box("contactData");
    // dataContact = await SharedPreferences.getInstance();
  }

  Widget tileDivider({double height = 22}) {
    return Divider(
      height: height,
      thickness: .25,
      color: KaiColor.black,
    );
  }

  Widget orderReview() {
    var addon = Provider.of<FlightDetailState>(context, listen: false).addon;
    
    return Container(
      decoration: const BoxDecoration(
        color: KaiColor.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 18.0,
              left: 18.0,
              right: 18.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: addon.map((addOns) {
                  return AddOnWidget(addOns);
                }).toList(),
                // children: [
                //   const Text(
                //     'Batik + Scoot',
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                //   const Text(
                //     'Friday, 28 May 2021',
                //     style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w400,
                //       color: KaiColor.black,
                //     ),
                //   ),
                //   Row(
                //     children: [
                //       Text(
                //         '15:00 (CGK) - 18:00 (SIN)',
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //           color: KaiColor.black.withOpacity(0.5),
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 5.0,
                //       ),
                //       SvgPicture.asset(
                //         'assets/svg/elipse.svg',
                //         color: KaiColor.black.withOpacity(0.5),
                //         height: 3.0,
                //       ),
                //       const SizedBox(
                //         width: 5.0,
                //       ),
                //       Text(
                //         'Direct',
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //           color: KaiColor.black.withOpacity(0.5),
                //         ),
                //       ),
                //     ],
                //   ),
                // ],
              ),
            ),
          ),
          tileDivider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Penumpang',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    '$seats Adult',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FlightDetailArguments;

    FlightDetailState state = Provider.of<FlightDetailState>(context);
    state.initState(context, scaffoldKey, args);
    print("Trip Type From Argument Detail: ${args.tripType}");

    if (args.idSchDepart != null) {
      setState(() {
        state.setIdSchDepart(args.idSchDepart!);
        state.setIdSchReturn(args.idSchReturn!);
        state.setSeat(args.adult!);
        if (args.adult != null) {
          seats = args.adult!;
        }
        if (args.child != null) {
          seatsChild = args.child!;
        }
        if (args.infant != null) {
          seatsInfant = args.infant!;
        }
      });

      for (var i = 0; i < args.detail!.departure!.length; i++) {
        for (var n = 0; n < args.detail!.departure![i].prices!.length; n++) {
          setState(() {
            if (totalPrice == 0) {
              totalPrice += args.detail!.departure![i].prices![n].totalFare!;
            }
          });
        }
      }
    }

    return Scaffold(
      backgroundColor: KaiColor.neutral11,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                          onTap: () => state.onBackButton(),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Isi Data",
                            style: KaiTextStyle.titleSmallBold
                                .apply(color: KaiColor.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 18,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: BookingDetailCard(args.detail!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: BookingContactForm(args.idSchDepart!, args.idSchReturn!),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                          child: Column(
                            children: List<BookingForm>.generate(seats!, (i) => BookingForm(i + 1, args.idSchDepart!, args.idSchReturn!, 'Adult', seats!)).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                          child: Column(
                            children: List<BookingForm>.generate(seatsChild!, (i) => BookingForm(i + 1, args.idSchDepart!, args.idSchReturn!, 'Child', seatsChild!)).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                          child: Column(
                            children: List<BookingForm>.generate(seatsInfant!, (i) => BookingForm(i + 1, args.idSchDepart!, args.idSchReturn!, 'Infant', seatsInfant!)).toList(),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                        //   child: ListView.builder(
                        //     itemCount: seats,
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, index) {
                        //       return BookingForm(index + 1, args.idSchDepart!, args.idSchReturn!);
                        //     }
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: KaiColor.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                              right: 18.0,
                              left: 18.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total Harga'),
                                Row(
                                  children: [
                                    Text(
                                      currencies.format(totalPrice),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: KaiColor.yellow,
                                      ),
                                    ),
                                    const Text(
                                      '/org',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    SvgPicture.asset(
                                      'assets/svg/drop_up.svg',
                                      width: 10.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          KaiButton(
                            text: 'Berikutnya',
                            onClick: () async {
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              var contacts = sharedPreferences.getString("ContactData");
                              FlightContactModel contact = FlightContactModel.fromJson(jsonDecode(contacts!));
                              for (var i = 0; i < seats!; i++) {
                                var passengers = sharedPreferences.getString("passenger_data_Adult_${i + 1}");
                                FlightPassengerModel passenger = FlightPassengerModel.fromJson(jsonDecode(passengers!));
                                contact.paxDetails!.add(passenger);
                              }
                              if (seatsChild != 0) {
                                for (var sc = 0; sc < seatsChild!; sc++) {
                                  var passengersChild = sharedPreferences.getString("passenger_data_Child_${sc + 1}");
                                  FlightPassengerModel passengerChild = FlightPassengerModel.fromJson(jsonDecode(passengersChild!));
                                  contact.paxDetails!.add(passengerChild);
                                }
                              }
                              if (seatsInfant != 0) {
                                for (var si = 0; si < seatsInfant!; si++) {
                                  var passengersInfant = sharedPreferences.getString("passenger_data_Infant_${si + 1}");
                                  FlightPassengerModel passengerInfant = FlightPassengerModel.fromJson(jsonDecode(passengersInfant!));
                                  contact.paxDetails!.add(passengerInfant);
                                }
                              }
                              // print(json.encode(contact));
                              var addon = await state.getAddOn(contact);
                              if (addon) {
                                await showModalBottomSheet(
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
                                            width: MediaQuery.of(context).size.width *
                                                0.2,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            top: 30.0,
                                          ),
                                          child: Text(
                                            'Data Add On',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        orderReview(),
                                        Row(
                                          children: [
                                            KaiCustomButton(
                                              text: 'Check Again',
                                              onClick: () {
                                                // state.onBackButton()
                                              },
                                              buttonColor:
                                                  KaiColor.blue.withOpacity(0.1),
                                              textColor: KaiColor.blue,
                                              sideColor:
                                                  KaiColor.blue.withOpacity(0.1),
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.4,
                                              height: 40,
                                            ),
                                            KaiCustomButton(
                                              text: 'Booking!',
                                              onClick: () async {
                                                // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                                // var contacts = sharedPreferences.getString("ContactData");
                                                // FlightContactModel contact = FlightContactModel.fromJson(jsonDecode(contacts!));
                                                // for (var i = 0; i < seats!; i++) {
                                                //   var passengers = sharedPreferences.getString("passenger_data_${i + 1}");
                                                //   FlightPassengerModel passenger = FlightPassengerModel.fromJson(jsonDecode(passengers!));
                                                //   contact.paxDetails!.add(passenger);
                                                // }
                                                var books = await state.bookings(args.idSchDepart, args.idSchReturn);

                                                if (books) {
                                                  state.onNextButton();
                                                }
                                              },
                                              buttonColor: KaiColor.blue,
                                              textColor: KaiColor.white,
                                              sideColor: KaiColor.blue,
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.4,
                                              height: 40,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            buttonColor: KaiColor.blue,
                            textColor: KaiColor.white,
                            sideColor: KaiColor.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     margin: EdgeInsets.zero,
      //     height: 75,
      //     child: Row(
      //       children: [
      //         const Spacer(),
      //         TextButton(
      //           onPressed: () async {
      //             SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      //             var contacts = sharedPreferences.getString("ContactData");
      //             FlightContactModel contact = FlightContactModel.fromJson(jsonDecode(contacts!));
      //             for (var i = 0; i < seats!; i++) {
      //               var passengers = sharedPreferences.getString("passenger_data_${i + 1}");
      //               FlightPassengerModel passenger = FlightPassengerModel.fromJson(jsonDecode(passengers!));
      //               contact.paxDetails!.add(passenger);
      //             }
      //           },
      //           child: const Text(
      //             'Book Now!',
      //             style: TextStyle(
      //               fontSize: 24,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
