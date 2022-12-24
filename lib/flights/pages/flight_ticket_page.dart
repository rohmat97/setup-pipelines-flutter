import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kai_wisata/data/models/airport.dart';
import 'package:kai_wisata/flights/caches/airport_cache.dart';
import 'package:kai_wisata/flights/models/flight_airports_model.dart';
import 'package:kai_wisata/flights/providers/flight_airports_state.dart';
import 'package:kai_wisata/flights/providers/flight_ticket_state.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';
import 'package:kai_wisata/flights/widgets/seat_qty_child_widget.dart';
import 'package:kai_wisata/flights/widgets/seat_qty_infant_widget.dart';
import 'package:kai_wisata/kai_reguler/providers/regular_ticket_state.dart';
import 'package:kai_wisata/flights/widgets/seat_qty_widget.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class FlightTicketPage extends StatefulWidget {
  static const routeName = '/flight-ticket-pages';

  const FlightTicketPage({Key? key}) : super(key: key);

  @override
  State<FlightTicketPage> createState() => _FlightTicketPageState();
}

class _FlightTicketPageState extends State<FlightTicketPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final _formKeyCap = GlobalKey<FormState>();

  FlightTicketState? state;
  FlightAirportsState? stateAp;
  List<dynamic> listAirports = [];
  List<AirportsModel> airports = [];
  Map<String, dynamic> dataAirport = {};
  final LocalStorage storage = LocalStorage('flight_data');

  String airportCity = "";

  TextEditingController orgController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController orgReqController = TextEditingController();
  TextEditingController desReqController = TextEditingController();
  TextEditingController accCodeController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      DateTime.now().year,
      DateTime.now().day,
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

  Future<dynamic> buildSeatBottomSheet(BuildContext context, FlightTicketState state,) {
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
            return SeatQty(state.seat, (seat) => {
              setModalState(() => {
                state.setSeat(seat)
              })
            });
          },
        );
      },
    );
  }

  Future<dynamic> buildSeatBottomSheetChild(BuildContext context, FlightTicketState state,) {
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
            return SeatQtyChild(state.seatChild, (seat) => {
              setModalState(() => {
                state.setSeatChild(seat)
              })
            });
          },
        );
      },
    );
  }

  Future<dynamic> buildSeatBottomSheetInfant(BuildContext context, FlightTicketState state,) {
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
            return SeatQtyInfant(state.seatInfant, (seat) => {
              setModalState(() => {
                if (state.seat >= seat) {
                  state.setSeatInfant(seat)
                }
              })
            });
          },
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context, Uint8List accCode) async {
    // return showModalBottomSheet(
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(10),
    //       topRight: Radius.circular(10),
    //     ),
    //   ),
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (context) => Container(
    //     decoration: const BoxDecoration(
    //       borderRadius: BorderRadius.vertical(
    //         top: Radius.circular(10.0),
    //       ),
    //       color: KaiColor.white,
    //     ),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(
    //             top: 8.0,
    //           ),
    //           child: SvgPicture.asset(
    //             'assets/svg/bar_line.svg',
    //             width: MediaQuery.of(context).size.width *
    //                 0.2,
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(
    //             top: 30.0,
    //           ),
    //           child: Form(
    //             key: _formKeyCap,
    //             child: Column(
    //               children: [
    //                 Image.memory(accCode),
    //                 KaiTextField(
    //                   widget: const Text(''),
    //                   obscure: false,
    //                   textController: accCodeController,
    //                   hint: 'Masukkan Kode Gambar',
    //                   color: KaiColor.homeBackground,
    //                   validator: (value) {
    //                     if (value == null || value.isEmpty) {
    //                       return "Wajib diisi dan tidak Boleh Kosong!";
    //                     }
    //                     return null;
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         KaiCustomButton(
    //           text: 'Tutup',
    //           onClick: () async {
    //             Navigator.pop(context);
    //           },
    //           buttonColor: KaiColor.blue,
    //           textColor: KaiColor.white,
    //           sideColor: KaiColor.blue,
    //           width: MediaQuery.of(context).size.width,
    //           height: 40,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Fill the Captcha'),
          content: Form(
            key: _formKeyCap,
            child: Column(
              children: [
                Image.memory(accCode),
                KaiTextField(
                  widget: const Text(''),
                  obscure: false,
                  textController: accCodeController,
                  hint: 'Masukkan Kode Gambar',
                  color: KaiColor.homeBackground,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Wajib diisi dan tidak Boleh Kosong!";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Lanjut Cari!'),
              onPressed: () async {
                if (_formKeyCap.currentState!.validate()) {
                  var suc = await state!.onNextButton(accCodeController.text);

                  if (suc) {
                    setState(() {
                      accCodeController.text = '';
                    });
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildNewTile(String title, String contentText, String icon,
      {Function? onTap, double subtitlePadding = 10}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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

  @override
  Widget build(BuildContext context) {

    state = Provider.of<FlightTicketState>(context);
    state?.initState(context, scaffoldKey);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                      'Pesawat',
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
                margin: const EdgeInsets.only(top: 18, left: 12, bottom: 18, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: KaiColor.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 18.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 18.0,
                                    left: 18.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Pilih Asal',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18, right: 18),
                                  child: TypeAheadFormField<AirportsModel?>(
                                    hideOnEmpty: true,
                                    hideOnError: true,
                                    hideSuggestionsOnKeyboardHide: true,
                                    textFieldConfiguration: TextFieldConfiguration(
                                      controller: orgController,
                                      decoration: const InputDecoration(
                                        prefixIcon: Image(image: AssetImage('assets/images/ic_plane_take_off_nounderline.png')),
                                        // border: OutlineInputBorder(),
                                        hintText: 'Pilih Asal...',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                      ),
                                    ),
                                    suggestionsCallback: FlightService().airports,
                                    itemBuilder: (context, AirportsModel? suggestion) {
                                      final airport = suggestion!;

                                      final cage = airport.airportCity!.contains(RegExp(r'[()]'));

                                      if (cage) {
                                        airportCity = airport.airportCity!;
                                      } else {
                                        airportCity = "${airport.airportCity} (${airport.airportCode})";
                                      }

                                      return ListTile(
                                        title: Text(airportCity),
                                      );
                                    },
                                    noItemsFoundBuilder: (context) => Container(
                                      margin: EdgeInsets.zero,
                                      child: const Center(
                                        child: Text(
                                          'Data not Found.',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                    onSuggestionSelected: (AirportsModel? suggestion) {
                                      final airport = suggestion!;
                                      state?.setFromAirport(airport);

                                      setState(() {
                                        orgController.text = '${state?.getFromAirport()}';
                                      });
                                    },
                                    validator: (value) {
                                      if (orgController.text.isEmpty) {
                                        return "Tempat asal harus diisi!";
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 18.0,
                                    left: 18.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Pilih Tujuan',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18, right: 18),
                                  child: TypeAheadFormField<AirportsModel?>(
                                    hideOnEmpty: true,
                                    hideOnError: true,
                                    hideSuggestionsOnKeyboardHide: true,
                                    textFieldConfiguration: TextFieldConfiguration(
                                      controller: desController,
                                      decoration: const InputDecoration(
                                        prefixIcon: Image(image: AssetImage('assets/images/ic_plane_landing_nounderline.png')),
                                        // border: OutlineInputBorder(),
                                        hintText: 'Pilih Tujuan...',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                      ),
                                    ),
                                    suggestionsCallback: FlightService().airports,
                                    itemBuilder: (context, AirportsModel? suggestion) {
                                      final airport = suggestion!;
                                      final cage = airport.airportCity!.contains(RegExp(r'[()]'));

                                      if (cage) {
                                        airportCity = airport.airportCity!;
                                      } else {
                                        airportCity = "${airport.airportCity} (${airport.airportCode})";
                                      }

                                      return ListTile(
                                        title: Text(airportCity),
                                      );
                                    },
                                    noItemsFoundBuilder: (context) => Container(
                                      margin: EdgeInsets.zero,
                                      child: const Center(
                                        child: Text(
                                          'Data not Found.',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                    onSuggestionSelected: (AirportsModel? suggestion) {
                                      final airport = suggestion!;
                                      state?.setToAirport(airport);

                                      setState(() {
                                        desController.text = '${state?.getToAirport()}';
                                      });
                                    },
                                    validator: (value) {
                                      if (desController.text.isEmpty) {
                                        return "Tempat tujuan harus diisi!";
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => _selectFromDate(context),
                            child: buildNewTile(
                              'Tanggal Pergi',
                              '${state?.getFromDate()}',
                              'assets/svg/calendar_blue.svg',
                              subtitlePadding: 18,
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
                                '${state?.getToDate()}',
                                'assets/svg/calendar_blue.svg',
                                subtitlePadding: 16,
                              )
                            ),
                            tileDivider(),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => buildSeatBottomSheet(context, state!),
                            child:
                            buildNewTile(
                              '',
                              '${state?.seat} Dewasa',
                              'assets/svg/psg_adult_cropped.svg',
                              subtitlePadding: 12,
                            ),
                          ),
                          InkWell(
                            onTap: () => buildSeatBottomSheetChild(context, state!),
                            child:
                            buildNewTile(
                              '',
                              '${state?.seatChild} Anak',
                              'assets/svg/psg_child_cropped.svg',
                              subtitlePadding: 8,
                            ),
                          ),
                          InkWell(
                            onTap: () => buildSeatBottomSheetInfant(context, state!),
                            child:
                            buildNewTile(
                              '',
                              '${state?.seatInfant} Bayi',
                              'assets/svg/psg_infant_cropped.svg',
                              subtitlePadding: 8,
                            ),
                          ),
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
                      const SizedBox(height: 18),
                      KaiButton(
                        text: 'Cari Tiket',
                        onClick: () async {
                          if (_formKey.currentState!.validate()) {
                            var res = await state!.onNextButton("");
                            if (res == false) {
                              if (state?.result?.image != null) {
                                Uint8List imageBytes = base64Decode(state!.result!.image!);
                                await _dialogBuilder(context, imageBytes);
                              }
                            }
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
            ],
          )
        ),
      ),
    );
  }
}