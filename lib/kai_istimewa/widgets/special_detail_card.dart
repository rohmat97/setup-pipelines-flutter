import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/kai_istimewa/arguments/special_arguments.dart';
import 'package:kai_wisata/kai_istimewa/models/special_description.dart';

class SpecialDetailCard extends StatelessWidget {
  const SpecialDetailCard({
    Key? key,
    this.args,
    this.onTap,
    this.capacity
  }) : super(key: key);

  final VoidCallback? onTap;
  final SpecialArguments? args;
  final SpecialDescription? capacity;

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
                      DateFormat("EEEE, dd MMM yyyy").format(args!.info.departure),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: KaiColor.black,
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
                child: Text(
                  "${args?.info.org.name} - ${args?.info.des.name}",
                  style: const TextStyle(
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
                  bottom: 18.0,
                ),
                child: Text(
                  "*Kapasitas ${this.capacity?.kapasitas} orang",
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
