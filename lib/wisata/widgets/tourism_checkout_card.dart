import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';

import 'package:intl/intl.dart';

class TourismCheckoutCard extends StatelessWidget {
  const TourismCheckoutCard({
    Key? key,
    this.onTap,
  }) : super(key: key);

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
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 18.0,
                  bottom: 9.0,
                ),
                child: Text(
                  'Kode: TLS14',
                  style: TextStyle(
                    color: KaiColor.black,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Text(
                  'Ticket',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KaiColor.black,
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
                  children: [
                    SvgPicture.asset('assets/svg/tree.svg'),
                    const Text(
                      'Ambarawa, Semarang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: KaiColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 18.0,
                ),
                child: Row(
                  children: List.generate(
                    150 ~/ 4,
                    (index) => Expanded(
                      child: Container(
                        color:
                            index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Text(
                  'Rincian Harga',
                  style: TextStyle(
                    color: KaiColor.black,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Harga Tiket',
                      style: TextStyle(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      'Rp 400.000',
                      style: TextStyle(
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
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Jumlah',
                      style: TextStyle(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      '2',
                      style: TextStyle(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '',
                      style: TextStyle(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      '_______________',
                      style: TextStyle(
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
                  bottom: 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '',
                      style: TextStyle(
                        color: KaiColor.black,
                      ),
                    ),
                    Text(
                      'Rp 800.000',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: KaiColor.black,
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
