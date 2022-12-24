import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';

import 'package:intl/intl.dart';

class TourismOrderCard extends StatelessWidget {
  const TourismOrderCard({
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
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://www.libur.co/wp-content/uploads/2021/10/Tempat-Wisata-Ambarawa-Semarang.jpg',
                        // height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
