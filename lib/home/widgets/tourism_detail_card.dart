import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/data/models/station.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/models/caches/station_caches.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_book_info.dart';

class TourismDetailCard extends StatelessWidget {
  const TourismDetailCard({
    Key? key,
    this.content,
    this.onTap,
  }) : super(key: key);

  final TourismBookInfo? content;
  final VoidCallback? onTap;

  String getStationName(String code, int limit) {
    var name = StationCaches.instance.get(code);
    return name.length > limit ? name.substring(0, limit - 3) + ".." : name;
  }

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
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 18.0,
                  bottom: 5.0,
                ),
                child: Text(
                  "${content?.transporterName} (${content?.transporterNo})",
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
                  "${content?.gerbongTipe}",
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
                              DateFormat("HH:mm").format(content!.depTime),
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
                                  DateFormat("dd MMM").format(content!.depTime),
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
                        Text("${content?.duration}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              DateFormat("HH:mm").format(content!.arvTime),
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
                                  DateFormat("dd MMM").format(content!.arvTime),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getStationName(content!.org, 10)} (${content!.org})",
                              style: KaiTextStyle.titleSmallBold.apply(
                                color: KaiColor.black,
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
                                  "${content!.org}",
                                  style: KaiTextStyle.titleSmallBold.apply(
                                    color: KaiColor.grey,
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
                        const Text(''),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getStationName(content!.des, 10)} (${content!.des})",
                              style: KaiTextStyle.titleSmallBold.apply(
                                color: KaiColor.black,
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
                                  "${getStationName(content!.des, 10)} (${content!.des})",
                                  style: KaiTextStyle.titleSmallBold.apply(
                                    color: KaiColor.grey,
                                    fontSizeDelta: -2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
