import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/models/histories/history_booking_data_model.dart';

import 'package:intl/intl.dart';

class FlightPlaneDetail extends StatelessWidget {
  const FlightPlaneDetail({
    Key? key,
    required this.contents,
    this.onTap,
  }) : super(key: key);

  final HistoryBookingDataModel contents;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: KaiColor.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: contents.routeInfo!.map((content) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                      top: 18.0,
                      bottom: 5.0,
                    ),
                    child: Text(
                      "${content.transporterName} (${content.transporterNo})",
                      style: KaiTextStyle.titleSmallBold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                      bottom: 5.0,
                    ),
                    child: Text(
                      "${contents.routeType}",
                      style: KaiTextStyle.titleSmallBold.apply(
                        color: KaiColor.grey,
                        fontSizeDelta: -2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                      bottom: 18.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  DateFormat("HH:mm").format(content.depDate!),
                                  style: KaiTextStyle.titleSmallBold.apply(
                                    color: KaiColor.blue,
                                    fontSizeDelta: 2,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: KaiColor.homeBackground.withOpacity(0.8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      top: 1.0,
                                      bottom: 1.0,
                                    ),
                                    child: Text(
                                      DateFormat("dd MMM").format(content.depDate!),
                                      style: KaiTextStyle.titleSmallBold.apply(
                                        fontSizeDelta: -2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Text("${content?.routeInfo.duration}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  DateFormat("HH:mm").format(content.arvDate!),
                                  style: KaiTextStyle.titleSmallBold.apply(
                                    color: KaiColor.blue,
                                    fontSizeDelta: 2,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: KaiColor.homeBackground.withOpacity(0.8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      top: 1.0,
                                      bottom: 1.0,
                                    ),
                                    child: Text(
                                      DateFormat("dd MMM").format(content.arvDate!),
                                      style: KaiTextStyle.titleSmallBold.apply(
                                        fontSizeDelta: -2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/step.svg',
                              height: 100,
                            ),
                            SvgPicture.asset('assets/svg/step2.svg'),
                          ],
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "${getStationName(content!.routeInfo!.org, 10)} (${content!.routeInfo!.org})",
                        //           style: KaiTextStyle.titleSmallBold.apply(
                        //             color: KaiColor.black,
                        //             fontSizeDelta: 2,
                        //           ),
                        //         ),
                        //         Container(
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(10),
                        //             color: KaiColor.homeBackground.withOpacity(0.8),
                        //           ),
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(
                        //               left: 5.0,
                        //               right: 5.0,
                        //               top: 1.0,
                        //               bottom: 1.0,
                        //             ),
                        //             child: Text(
                        //               "${content!.routeInfo!.org}",
                        //               style: KaiTextStyle.titleSmallBold.apply(
                        //                 color: KaiColor.grey,
                        //                 fontSizeDelta: -2,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     const SizedBox(
                        //       height: 10,
                        //     ),
                        //     const Text(''),
                        //     const SizedBox(
                        //       height: 10,
                        //     ),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "${getStationName(content!.routeInfo!.des, 10)} (${content!.routeInfo!.des})",
                        //           style: KaiTextStyle.titleSmallBold.apply(
                        //             color: KaiColor.black,
                        //             fontSizeDelta: 2,
                        //           ),
                        //         ),
                        //         Container(
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(10),
                        //             color: KaiColor.homeBackground.withOpacity(0.8),
                        //           ),
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(
                        //               left: 5.0,
                        //               right: 5.0,
                        //               top: 1.0,
                        //               bottom: 1.0,
                        //             ),
                        //             child: Text(
                        //               "${getStationName(content!.routeInfo!.des, 10)} (${content!.routeInfo!.des})",
                        //               style: KaiTextStyle.titleSmallBold.apply(
                        //                 color: KaiColor.grey,
                        //                 fontSizeDelta: -2,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
            // children: [
            //   // Padding(
            //   //   padding: const EdgeInsets.only(
            //   //     left: 18.0,
            //   //     right: 18.0,
            //   //     top: 18.0,
            //   //     bottom: 5.0,
            //   //   ),
            //   //   child: Text(
            //   //     "${content?.routeInfo?.transporterName} (${content?.routeInfo?.transporterNo})",
            //   //     style: KaiTextStyle.titleSmallBold,
            //   //   ),
            //   // ),
            //   // Padding(
            //   //   padding: const EdgeInsets.only(
            //   //     left: 18.0,
            //   //     right: 18.0,
            //   //     bottom: 5.0,
            //   //   ),
            //   //   child: Text(
            //   //     "${content?.routeInfo?.transporterType}",
            //   //     style: KaiTextStyle.titleSmallBold.apply(
            //   //       color: KaiColor.grey,
            //   //       fontSizeDelta: -2,
            //   //     ),
            //   //   ),
            //   // ),
            //   // Padding(
            //   //   padding: const EdgeInsets.only(
            //   //     left: 18.0,
            //   //     right: 18.0,
            //   //     bottom: 18.0,
            //   //   ),
            //   //   child: Row(
            //   //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   //     children: [
            //   //       Column(
            //   //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   //         children: [
            //   //           Column(
            //   //             children: [
            //   //               Text(
            //   //                 DateFormat("HH:mm").format(content!.routeInfo!.depDate),
            //   //                 style: KaiTextStyle.titleSmallBold.apply(
            //   //                   color: KaiColor.blue,
            //   //                   fontSizeDelta: 2,
            //   //                 ),
            //   //               ),
            //   //               Container(
            //   //                 decoration: BoxDecoration(
            //   //                   borderRadius: BorderRadius.circular(10),
            //   //                   color: KaiColor.homeBackground.withOpacity(0.8),
            //   //                 ),
            //   //                 child: Padding(
            //   //                   padding: const EdgeInsets.only(
            //   //                     left: 5.0,
            //   //                     right: 5.0,
            //   //                     top: 1.0,
            //   //                     bottom: 1.0,
            //   //                   ),
            //   //                   child: Text(
            //   //                     DateFormat("dd MMM").format(content!.routeInfo!.depDate),
            //   //                     style: KaiTextStyle.titleSmallBold.apply(
            //   //                       fontSizeDelta: -2,
            //   //                     ),
            //   //                   ),
            //   //                 ),
            //   //               ),
            //   //             ],
            //   //           ),
            //   //           const SizedBox(
            //   //             height: 10,
            //   //           ),
            //   //           Text("${content?.routeInfo.duration}"),
            //   //           const SizedBox(
            //   //             height: 10,
            //   //           ),
            //   //           Column(
            //   //             children: [
            //   //               Text(
            //   //                 DateFormat("HH:mm").format(content!.routeInfo!.arvDate),
            //   //                 style: KaiTextStyle.titleSmallBold.apply(
            //   //                   color: KaiColor.blue,
            //   //                   fontSizeDelta: 2,
            //   //                 ),
            //   //               ),
            //   //               Container(
            //   //                 decoration: BoxDecoration(
            //   //                   borderRadius: BorderRadius.circular(10),
            //   //                   color: KaiColor.homeBackground.withOpacity(0.8),
            //   //                 ),
            //   //                 child: Padding(
            //   //                   padding: const EdgeInsets.only(
            //   //                     left: 5.0,
            //   //                     right: 5.0,
            //   //                     top: 1.0,
            //   //                     bottom: 1.0,
            //   //                   ),
            //   //                   child: Text(
            //   //                     DateFormat("dd MMM").format(content!.routeInfo!.arvDate),
            //   //                     style: KaiTextStyle.titleSmallBold.apply(
            //   //                       fontSizeDelta: -2,
            //   //                     ),
            //   //                   ),
            //   //                 ),
            //   //               ),
            //   //             ],
            //   //           ),
            //   //         ],
            //   //       ),
            //   //       Column(
            //   //         children: [
            //   //           SvgPicture.asset(
            //   //             'assets/svg/step.svg',
            //   //             height: 100,
            //   //           ),
            //   //           SvgPicture.asset('assets/svg/step2.svg'),
            //   //         ],
            //   //       ),
            //   //       Column(
            //   //         crossAxisAlignment: CrossAxisAlignment.start,
            //   //         children: [
            //   //           Column(
            //   //             crossAxisAlignment: CrossAxisAlignment.start,
            //   //             children: [
            //   //               Text(
            //   //                 "${getStationName(content!.routeInfo!.org, 10)} (${content!.routeInfo!.org})",
            //   //                 style: KaiTextStyle.titleSmallBold.apply(
            //   //                   color: KaiColor.black,
            //   //                   fontSizeDelta: 2,
            //   //                 ),
            //   //               ),
            //   //               Container(
            //   //                 decoration: BoxDecoration(
            //   //                   borderRadius: BorderRadius.circular(10),
            //   //                   color: KaiColor.homeBackground.withOpacity(0.8),
            //   //                 ),
            //   //                 child: Padding(
            //   //                   padding: const EdgeInsets.only(
            //   //                     left: 5.0,
            //   //                     right: 5.0,
            //   //                     top: 1.0,
            //   //                     bottom: 1.0,
            //   //                   ),
            //   //                   child: Text(
            //   //                     "${content!.routeInfo!.org}",
            //   //                     style: KaiTextStyle.titleSmallBold.apply(
            //   //                       color: KaiColor.grey,
            //   //                       fontSizeDelta: -2,
            //   //                     ),
            //   //                   ),
            //   //                 ),
            //   //               ),
            //   //             ],
            //   //           ),
            //   //           const SizedBox(
            //   //             height: 10,
            //   //           ),
            //   //           const Text(''),
            //   //           const SizedBox(
            //   //             height: 10,
            //   //           ),
            //   //           Column(
            //   //             crossAxisAlignment: CrossAxisAlignment.start,
            //   //             children: [
            //   //               Text(
            //   //                 "${getStationName(content!.routeInfo!.des, 10)} (${content!.routeInfo!.des})",
            //   //                 style: KaiTextStyle.titleSmallBold.apply(
            //   //                   color: KaiColor.black,
            //   //                   fontSizeDelta: 2,
            //   //                 ),
            //   //               ),
            //   //               Container(
            //   //                 decoration: BoxDecoration(
            //   //                   borderRadius: BorderRadius.circular(10),
            //   //                   color: KaiColor.homeBackground.withOpacity(0.8),
            //   //                 ),
            //   //                 child: Padding(
            //   //                   padding: const EdgeInsets.only(
            //   //                     left: 5.0,
            //   //                     right: 5.0,
            //   //                     top: 1.0,
            //   //                     bottom: 1.0,
            //   //                   ),
            //   //                   child: Text(
            //   //                     "${getStationName(content!.routeInfo!.des, 10)} (${content!.routeInfo!.des})",
            //   //                     style: KaiTextStyle.titleSmallBold.apply(
            //   //                       color: KaiColor.grey,
            //   //                       fontSizeDelta: -2,
            //   //                     ),
            //   //                   ),
            //   //                 ),
            //   //               ),
            //   //             ],
            //   //           ),
            //   //         ],
            //   //       ),
            //   //     ],
            //   //   ),
            //   // ),
            // ],
          ),
        ),
      ),
    );
  }
}