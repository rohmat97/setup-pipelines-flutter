import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/arguments/flight_result_arguments.dart';
import 'package:kai_wisata/flights/models/flight_result_model.dart';
import 'package:kai_wisata/flights/models/flight_schedules_model.dart';
import 'package:kai_wisata/flights/providers/flight_detail_state.dart';
import 'package:kai_wisata/flights/providers/flight_result_state.dart';
import 'package:kai_wisata/helpers/theme.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightListCard extends StatefulWidget {
  final FlightSchedulesModel sch;
  final String types;
  final VoidCallback onTap;
  const FlightListCard(this.sch, this.types, {Key? key, required this.onTap}) : super(key: key);

  @override
  State<FlightListCard> createState() => _FlightListCardState();
}

class _FlightListCardState extends State<FlightListCard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final currencies = NumberFormat.simpleCurrency(locale: 'id_ID');
  FlightResultState state = FlightResultState();
  FlightDetailState stateDt = FlightDetailState();

  String flightLogo = "";

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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FlightResultArguments;
    FlightResultState state = Provider.of<FlightResultState>(context);
    state.initState(context, scaffoldKey, args);
    
    setState(() {
      if (widget.sch.airlineCode == "QG") {
        flightLogo = "assets/images/flight_citilink.png";
      } else if (widget.sch.airlineCode == "QZ") {
        flightLogo = "assets/images/flight_airasia.png";
      } else if (widget.sch.airlineCode == "JT") {
        flightLogo = "assets/images/flight_lionair.png";
      }
    });

    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: Card(
          elevation: 10,
          shadowColor: Colors.black,
          color: KaiColor.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(
                            '${widget.sch.airline}',
                            style: const TextStyle(
                              color: KaiColor.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                borderRadius:BorderRadius.circular(50),
                                child: Image.asset(flightLogo),
                              )
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                        // ignore: unnecessary_brace_in_string_interps
                                        child: Text(DateFormat("HH:mm").format(widget.sch.departureDate!)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                        child: Text('${widget.sch.origin}'),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4),
                                        child: Text(
                                          '${widget.sch.travelTime}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Container(
                                          height: 2,
                                          width: MediaQuery.of(context).size.width / 2.75,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4),
                                        child: Text(
                                          '${widget.sch.flightType}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                        // ignore: unnecessary_brace_in_string_interps
                                        child: Text(DateFormat("HH:mm").format(widget.sch.arriveDate!)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                        child: Text('${widget.sch.destination}'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12,),
                        tileDivider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.zero,
                                child: const Text(
                                  'IDR',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Container(
                                margin: EdgeInsets.zero,
                                child: Text(
                                  currencies.format(widget.sch.priceDetail),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      '${widget.sch.flightClass}',
                                      style: const TextStyle(
                                        color: KaiColor.white,
                                        fontSize: 10
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.lightBlueAccent[400],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}