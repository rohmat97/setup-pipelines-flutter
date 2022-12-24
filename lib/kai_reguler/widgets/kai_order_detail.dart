import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/data/models/station.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/models/caches/station_caches.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

class KaiOrderDetail extends StatelessWidget {
  const KaiOrderDetail({
    Key? key,
    this.schedule,
    this.onTap,
  }) : super(key: key);

  final RailSchedule? schedule;
  final VoidCallback? onTap;

  String getJourneyInfo(RailSchedule sch){
    var caches = StationCaches.instance;
    Station ori = Station(sch.origin, caches.get(sch.origin));
    Station dest = Station(sch.destination, caches.get(sch.destination));

    return "${ori.getCutName(7)} - ${dest.getCutName(7)}";
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KaiColor.white,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 18, top: 18, right: 18),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${schedule?.longDate}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black.withOpacity(0.6),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      'Lihat Detail',
                      style: KaiTextStyle.bodySmallBold.apply(
                        color: KaiColor.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, top: 9),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                getJourneyInfo(schedule!),
                style: KaiTextStyle.bodyLargeBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, top: 9),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                "${schedule?.durationInfo}",
                style: KaiTextStyle.bodySmallMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, top: 9, bottom: 18),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                "${schedule?.railInfo}",
                style: KaiTextStyle.bodySmallMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
