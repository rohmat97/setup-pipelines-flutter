import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/flights/arguments/flight_result_arguments.dart';
import 'package:kai_wisata/flights/caches/schedule_cache.dart';
import 'package:kai_wisata/flights/models/flight_detail_model.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';
import 'package:kai_wisata/flights/models/flight_schedule_model.dart';
import 'package:kai_wisata/flights/models/flight_schedules_model.dart';
import 'package:kai_wisata/flights/providers/flight_detail_state.dart';
import 'package:kai_wisata/flights/providers/flight_result_state.dart';
import 'package:kai_wisata/flights/providers/flight_schedule_state.dart';
import 'package:kai_wisata/flights/widgets/flight_list_card_widget.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightResultPage extends StatefulWidget {
  static const routeName = '/flight-result-pages';
  
  const FlightResultPage({Key? key}) : super(key: key);

  @override
  State<FlightResultPage> createState() => _FlightResultPageState();
}

class _FlightResultPageState extends State<FlightResultPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  // final _formKeyCap = GlobalKey<FormState>();
  FlightResultState state = FlightResultState();
  FlightDetailState stateDt = FlightDetailState();

  DateTime currentPhoneDate = DateTime.now();

  var inputFormat = DateFormat('HH:mm');

  Map<String, dynamic> resultData = {};
  List schedules = [];
  List schedulesReturn = [];

  bool departFilled = false;
  bool returnFilled = false;

  String idSchDepart = '';
  String idSchReturn = '';

  TextEditingController accCodeController = TextEditingController();

  @override
  void initState() {
    getInit();
    clearSharedPrefs();
    super.initState();
  }

  getInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('id_depart', "");
    sharedPreferences.setString('id_return', "");
  }

  clearSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id_depart');
    prefs.remove('id_return');
  }

  Widget tileDivider({double width = 22}) {
    return VerticalDivider(
      width: width,
      thickness: .25,
      color: KaiColor.white,
    );
  }

  buildEmptyResult() {
    return [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/not_found.png',
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          Text(
            "Pesawat Tidak Tersedia",
            style: KaiTextStyle.bodyLargeBold.apply(color: KaiColor.black),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Maaf, penerbangan yang sesuai dengan pencarian Anda tidak tersedia. Silakan pilih tanggal lain atau ubah pencarian Anda",
              textAlign: TextAlign.center,
              style: KaiTextStyle.bodyLargeMedium,
            ),
          ),
        ],
      )
    ];
  }

  buildIndicator() {
    return [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(top: 10),
            child: const LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [KaiColor.primary],
              strokeWidth: 2,
              backgroundColor: KaiColor.neutral11,
              pathBackgroundColor: KaiColor.neutral11,
            ),
          ),
        ],
      )
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadIdDepart() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idSchDepart = prefs.getString("id_depart") ?? '' ;
    });
  }

  Future<void> _saveIdDepart(String idDepart) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('id_depart', idDepart);
    });
  }

  Future<void> _loadIdReturn() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idSchDepart = prefs.getString("id_return") ?? '' ;
    });
  }

  Future<void> _saveIdReturn(String idReturn) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('id_return', idReturn);
    });
  }

  Future<void> _dialogBuilder(BuildContext context, Uint8List accCode) async {
    final _formKeyCap = GlobalKey<FormState>();
    final args = ModalRoute.of(context)!.settings.arguments as FlightResultArguments;

    FlightResultState state = Provider.of<FlightResultState>(context, listen: false);
    state.initState(context, scaffoldKey, args);
    
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
                  // print(args.tripType);
                  setState(() {
                    state.setReqBodySchedule(args.from!, args.to!, args.fromDate!, args.toDate!, args.adult!, args.child!, args.infant!, args.tripType!);
                    state.setSeat(args.adult!);
                    state.setSeatChild(args.child!);
                    state.setSeatInfant(args.infant!);
                  });
                  
                  if (idSchDepart != '' && args.tripType == 'OneWay') {
                    state.setIdSchDepart(idSchDepart);
                    state.setIdSchReturn("");
                    // FlightDetailModel res = await state.getScheduleDetail(idSchDepart, "", accCodeController.text);
                    var res = await state.onNextButton(context, accCodeController.text);

                    if (res) {
                      await stateDt.getScheduleDetail(idSchDepart, "", accCodeController.text);
                      setState(() {
                        accCodeController.text = '';
                      });
                      Navigator.pop(context);
                    }
                  }
                  if (idSchDepart != '' && args.tripType == 'RoundTrip') {
                    state.setIdSchDepart(idSchDepart);
                    state.setIdSchReturn(idSchReturn);
                    // FlightDetailModel res = await state.getScheduleDetail(idSchDepart, "", accCodeController.text);
                    var res = await state.onNextButton(context, accCodeController.text);

                    if (res) {
                      await stateDt.getScheduleDetail(idSchDepart, idSchReturn, accCodeController.text);
                      setState(() {
                        accCodeController.text = '';
                      });
                      Navigator.pop(context);
                    }
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FlightResultArguments;

    FlightResultState state = Provider.of<FlightResultState>(context);
    state.initState(context, scaffoldKey, args);

    setState(() {
      state.setReqBodySchedule(args.from!, args.to!, args.fromDate!, args.toDate!, args.adult!, args.child!, args.infant!, args.tripType!);
      state.setSeat(args.adult!);
      state.setSeatChild(args.child!);
      state.setSeatInfant(args.infant!);
    });

    if (schedules.isEmpty) {
      for (var dpt in args.result!.schedules!.departures!) {
        schedules.add(dpt);
      }
    }

    if (schedulesReturn.isEmpty) {
      if (args.tripType == "RoundTrip") {
        for (var rtn in args.result!.schedules!.returns!) {
          schedulesReturn.add(rtn);
        }
      }
    }

    if (idSchDepart == "" && idSchReturn == "") {
      departFilled = true;
      returnFilled = false;
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
                            "${args.from} - ${args.to}",
                            style: KaiTextStyle.titleSmallBold
                                .apply(color: KaiColor.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              // state.getHeaderDescription(),
                              DateFormat("dd MMM yyyy").format(args.fromDate!),
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                args.tripType == "OneWay" ? Expanded(
                  flex: 18,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: schedules.isNotEmpty ? schedules.map((sch) => FlightListCard(sch, "departs", onTap: () async {
                        // await clearSharedPrefs();
                        setState(() {
                          state.setReqBodySchedule(args.from!, args.to!, args.fromDate!, args.toDate!, args.adult!, args.child!, args.infant!, args.tripType!);
                          state.setSeat(args.adult!);
                          state.setSeatChild(args.child!);
                          state.setSeatInfant(args.infant!);
                        });
                        
                        FlightSchedulesModel schm = sch;
                        await _saveIdDepart(schm.idReference!);
                        await _loadIdDepart();

                        if (idSchDepart != '') {
                          state.setIdSchDepart(idSchDepart);
                          state.setIdSchReturn("");
                          // FlightDetailModel res = await state.getScheduleDetail(idSchDepart, "", "");
                          var res = await state.onNextButton(context, "");

                          if (res == false) {
                            if (state.detail?.image != null) {
                              Uint8List imageBytes = base64Decode(state.detail!.image!);
                              await _dialogBuilder(context, imageBytes);
                            }
                          }
                        }
                      },)).toList() : buildEmptyResult(),
                    ),
                  ),
                ) : Visibility(
                  visible: departFilled,
                  child: Expanded(
                    flex: 18,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // children: [],
                        children: schedules.isNotEmpty ? schedules.map((sch) => FlightListCard(sch, "departs", onTap: () async {
                          FlightSchedulesModel schm = sch;
                          await _saveIdDepart(schm.idReference!);
                          await _loadIdDepart();
                          if (idSchDepart != "" && idSchReturn == "") {
                            departFilled = false;
                            returnFilled = true;
                          }
                        },)).toList() : buildEmptyResult(),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: returnFilled,
                  child: Expanded(
                    flex: 18,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // children: [],
                        children: schedulesReturn.map((sch) => FlightListCard(sch, "returns", onTap: () async {
                          // state.setReqBodySchedule(args.from!, args.to!, args.fromDate!, args.toDate!, args.adult!, args.child!, args.infant!, args.tripType!);
                          // state.setSeat(args.adult!);
                          // state.setSeatChild(args.child!);
                          // state.setSeatInfant(args.infant!);

                          setState(() {
                            state.setReqBodySchedule(args.from!, args.to!, args.fromDate!, args.toDate!, args.adult!, args.child!, args.infant!, args.tripType!);
                            state.setSeat(args.adult!);
                            state.setSeatChild(args.child!);
                            state.setSeatInfant(args.infant!);
                          });
                          
                          FlightSchedulesModel schm = sch;
                          if (idSchDepart != '') {
                            state.setIdSchDepart(idSchDepart);
                            state.setIdSchReturn(schm.idReference!);

                            setState(() {
                              idSchReturn = schm.idReference!;
                            });

                            var res = await state.onNextButton(context, "");

                            if (res == false) {
                              if (state.detail?.image != null) {
                                Uint8List imageBytes = base64Decode(state.detail!.image!);
                                await _dialogBuilder(context, imageBytes);
                              }
                            }
                            // var res = await state.getScheduleDetail(idSchDepart, schm.idReference, "");
                            
                            // if (res.success!) {
                            //   await stateDt.getScheduleDetail(idSchDepart, schm.idReference, "");
                            //   await clearSharedPrefs();
                            //   state.onNextButton(context, "");
                            // } else {
                            //   print(res.image);
                            // }
                          }
                        },)).toList(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: KaiColor.neutral11,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => showModalBottomSheet(
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Urut Berdasarkan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.close),
                                          )
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Termurah',
                                      ),
                                      leading: Radio(
                                        value: SortResult.cheapest,
                                        groupValue: state.sort,
                                        onChanged: (SortResult? value) {
                                          state.changeSort(value!);
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Berangkat Paling Awal',
                                      ),
                                      leading: Radio(
                                        value: SortResult.earliest,
                                        groupValue: state.sort,
                                        onChanged: (SortResult? value) {
                                          state.changeSort(value!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 20.0,
                                      ),
                                      child: ListTile(
                                        title: const Text(
                                          'Berangkat Paling Akhir',
                                        ),
                                        leading: Radio(
                                          value: SortResult.latest,
                                          groupValue: state.sort,
                                          onChanged: (SortResult? value) {
                                            state.changeSort(value!);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/urut.svg',
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  'Urutkan',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: KaiColor.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/filter_new.svg',
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: KaiColor.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/calendar.svg',
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  'Ubah Tanggal',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: KaiColor.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}