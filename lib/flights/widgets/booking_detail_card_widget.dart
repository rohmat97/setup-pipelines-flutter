import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/models/details/flight_journer_return_model.dart';
import 'package:kai_wisata/flights/models/details/flight_journey_departure_model.dart';
import 'package:kai_wisata/flights/models/flight_detail_model.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';

import 'package:intl/intl.dart';

class BookingDetailCard extends StatefulWidget {
  final FlightDetailModel detail;
  const BookingDetailCard(this.detail, {Key? key}) : super(key: key);

  @override
  State<BookingDetailCard> createState() => _BookingDetailCardState();
}

class _BookingDetailCardState extends State<BookingDetailCard> {
  bool isExpander = false;
  bool isExpanding = false;

  bool isExpanderReturn = false;
  bool isExpandingReturn = false;

  String flightLogo = "";

  bool isReturn = false;

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
    setState(() {
      if (widget.detail.airlineCode == "QG") {
        flightLogo = "assets/images/flight_citilink.png";
      } else if (widget.detail.airlineCode == "QZ") {
        flightLogo = "assets/images/flight_airasia.png";
      } else if (widget.detail.airlineCode == "JT") {
        flightLogo = "assets/images/flight_lionair.png";
      }
    });

    if (widget.detail.returnee != null) {
      isReturn = true;
    }

    print(json.encode(widget.detail.departure?[0]));
    print(json.encode(widget.detail.returnee?[0]));

    return Center(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                'Detail Penerbangan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 4,
              shadowColor: Colors.black,
              color: KaiColor.white,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius:BorderRadius.circular(50),
                                  child: Image.asset(flightLogo),
                                )
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text(
                                    'Tanggal Berangkat',
                                    style: TextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    DateFormat("dd-MM-yyyy").format(widget.detail.departure![0].departureDate!),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${widget.detail.origin}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius:BorderRadius.circular(50),
                                  child: Image.asset('assets/images/ic_plane.png'),
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${widget.detail.destination}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${widget.detail.airlineCode} ${widget.detail.departure?[0].flightNumber}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text('|'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${DateFormat('HH:mm').format(widget.detail.departure![0].departureDate!)} ${DateFormat('HH:mm').format(widget.detail.departure![0].arriveDate!)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text('|'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                widget.detail.departure![0].flightType!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        child: ExpansionPanelList(
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              isExpander = !isExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return const ListTile(
                                  title: Text('Detail Penerbangan'),
                                );
                              },
                              body: Container(
                                margin: const EdgeInsets.all(10),
                                child: ExpansionPanelList(
                                  expansionCallback: (int index, bool isExpands) {
                                    setState(() {
                                      isExpanding = !isExpands;
                                    });
                                  },
                                  children: widget.detail.departure!.map<ExpansionPanel>((FlightJourneyDepartureModel journeyDeparture) {
                                    return ExpansionPanel(
                                      headerBuilder: (BuildContext context, bool isExpands) {
                                        return ListTile(
                                          title: Text('${journeyDeparture.origin} ${journeyDeparture.destination}'),
                                        );
                                      },
                                      body: ListTile(
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        DateFormat('HH:mm').format(journeyDeparture.departureDate!),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        DateFormat('dd MMMM').format(journeyDeparture.departureDate!),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '${widget.detail.airline} ${journeyDeparture.flightNumber}',
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${journeyDeparture.origin}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        DateFormat('HH:mm').format(journeyDeparture.arriveDate!),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        DateFormat('dd MMMM').format(journeyDeparture.arriveDate!),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${journeyDeparture.destination}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      isExpanded: isExpanding,
                                    );
                                  }).toList(),
                                ),
                              ),
                              isExpanded: isExpander,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  widget.detail.returnee!.isNotEmpty && isReturn == true ? tileDivider() : const SizedBox(),
                  widget.detail.returnee!.isNotEmpty && isReturn == true ? Visibility(
                    visible: isReturn,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius:BorderRadius.circular(50),
                                    child: Image.asset(flightLogo),
                                  )
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Text(
                                      'Tanggal Kembali',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      DateFormat("dd-MM-yyyy").format(widget.detail.returnee![0].departureDate!),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  '${widget.detail.returnee?[0].origin}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius:BorderRadius.circular(50),
                                    child: Image.asset('assets/images/ic_plane.png'),
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  '${widget.detail.returnee?[0].destination}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  '${widget.detail.airlineCode} ${widget.detail.returnee?[0].flightNumber}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Text('|'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  DateFormat('HH:mm').format(widget.detail.returnee![0].departureDate!) + ' - ' + DateFormat('HH:mm').format(widget.detail.returnee![0].arriveDate!),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Text('|'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  '${widget.detail.returnee?[0].flightType}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          width: MediaQuery.of(context).size.width,
                          child: ExpansionPanelList(
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                isExpanderReturn = !isExpanded;
                              });
                            },
                            children: [
                              ExpansionPanel(
                                headerBuilder: (BuildContext context, bool isExpanded) {
                                  return const ListTile(
                                    title: Text('Detail Penerbangan'),
                                  );
                                },
                                body: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: ExpansionPanelList(
                                    expansionCallback: (int index, bool isExpands) {
                                      setState(() {
                                        isExpandingReturn = !isExpands;
                                      });
                                    },
                                    children: widget.detail.returnee!.map<ExpansionPanel>((FlightJourneyReturnModel journeyReturn) {
                                      return ExpansionPanel(
                                        headerBuilder: (BuildContext context, bool isExpands) {
                                          return ListTile(
                                            title: Text('${journeyReturn.origin} ${journeyReturn.destination}'),
                                          );
                                        },
                                        body: ListTile(
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                          DateFormat('HH:mm').format(journeyReturn.departureDate!),
                                                          style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Text(
                                                          DateFormat('dd MMMM').format(journeyReturn.departureDate!),
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '${widget.detail.airline} ${journeyReturn.flightNumber}',
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${journeyReturn.origin}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                          DateFormat('HH:mm').format(journeyReturn.arriveDate!),
                                                          style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Text(
                                                          DateFormat('dd MMMM').format(journeyReturn.arriveDate!),
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${journeyReturn.destination}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        isExpanded: isExpandingReturn,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                isExpanded: isExpanderReturn,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ) : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}