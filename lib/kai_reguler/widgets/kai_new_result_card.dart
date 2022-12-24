import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/models/rail_schedule.dart';

import 'package:intl/intl.dart';

class KaiNewResultCard extends StatelessWidget {
  const KaiNewResultCard({
    Key? key,
    this.schedule,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;
  final RailSchedule? schedule;

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
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 18.0,
                  bottom: 9.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      schedule!.vendor,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: KaiColor.black,
                      ),
                    ),
                    //New Row
                    RichText(
                      text: TextSpan(
                        text: schedule!.fare,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: KaiColor.yellow,
                        ),
                        children: [
                          TextSpan(
                            text: '/org',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: KaiColor.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${schedule?.kelas}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: KaiColor.grey,
                      ),
                    ),
                    const Text(
                      '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: KaiColor.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          DateFormat("HH:mm").format(schedule!.departureTime),
                          style: KaiTextStyle.bodyLargeBold
                              .copyWith(fontSize: 20.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KaiColor.blue.withOpacity(0.4),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                              right: 5.0,
                              top: 1.0,
                              bottom: 1.0,
                            ),
                            child: Text(
                              schedule!.origin,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      children: [
                        Text(
                          schedule!.duration,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: KaiColor.black,
                          ),
                        ),
                        const Text(
                          'Langsung',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: KaiColor.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      children: [
                        Text(
                          DateFormat("HH:mm").format(schedule!.arrivalTime),
                          style: KaiTextStyle.bodyLargeBold
                              .copyWith(fontSize: 20.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KaiColor.blue.withOpacity(0.4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                              right: 5.0,
                              top: 1.0,
                              bottom: 1.0,
                            ),
                            child: Text(
                              schedule!.destination,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: KaiColor.grey,
                      ),
                    ),
                    Text(
                      'Pilih',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: KaiColor.blue,
                      ),
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
