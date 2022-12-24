import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/kai_wisata/arguments/tourism_customer_arguments.dart';
import 'package:kai_wisata/kai_wisata/arguments/tourism_detail_arguments.dart';

import 'package:kai_wisata/data/models/station.dart';
import 'package:kai_wisata/kai_reguler/models/caches/station_caches.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_schedule.dart';

class TourismDetailCard extends StatelessWidget {
  const TourismDetailCard({
    Key? key,
    this.onTap,
    this.args,
  }) : super(key: key);

  final VoidCallback? onTap;
  final TourismCustomerArguments? args;

  String getJourneyInfo(TourismSchedule sch) {
    var caches = StationCaches.instance;
    Station ori = Station(sch.origin, caches.get(sch.origin));
    Station dest = Station(sch.destination, caches.get(sch.destination));

    return "${ori.getCutName(7)} - ${dest.getCutName(7)}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          right: 18.0,
          top: 5.0,
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
                  bottom: 9.0,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/ic_train.svg'),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "${args?.schedule.longDate}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: KaiColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Text(
                  // "${args?.schedule.origin} - ${args?.schedule.destination}",
                  getJourneyInfo(args!.schedule),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: KaiColor.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Text(
                  "${args?.schedule.hourDepart} - ${args?.schedule.hourArrive}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KaiColor.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Text(
                  "${args?.schedule.transporterName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KaiColor.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Text(
                  "Gerbong ${args?.wagon.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KaiColor.yellow,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 18.0,
                ),
                child: Text(
                  '*Kapasitas ${args?.wagon.capacity} Orang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KaiColor.grey,
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
