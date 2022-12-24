import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';

import 'package:intl/intl.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_tipe.dart';

class TourismWagonCard extends StatelessWidget {
  const TourismWagonCard({
    Key? key,
    this.onTap,
    this.wagon,
  }) : super(key: key);

  final VoidCallback? onTap;
  final TourismTipe? wagon;

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
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 18.0,
                  bottom: 9.0,
                ),
                child: Text(
                  "${wagon?.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KaiColor.black,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                ),
                child: Text(
                  'Deskripsi : ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: KaiColor.grey,
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
                  "${wagon?.description}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: KaiColor.grey,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                ),
                child: Text(
                  'Fasilitas : ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: KaiColor.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/restaurant.svg',
                      width: 25.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    SvgPicture.asset(
                      'assets/svg/fastfood.svg',
                      width: 25.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                ),
                child: Text(
                  "Seat : ${wagon?.capacity}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: KaiColor.grey,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      NumberFormat.decimalPattern("Id")
                          .format(wagon!.estimated_price),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: KaiColor.yellow,
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
