import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';

import 'package:intl/intl.dart';

class TourismCard extends StatelessWidget {
  const TourismCard({
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
                    padding: const EdgeInsets.all(8.0),
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
                          'Ambarawa, Semarang',
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
                          bottom: 5.0,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/map.svg',
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 5.0,
                              ),
                              child: Text(
                                'Sekitar 11km',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: KaiColor.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 18.0,
                          right: 18.0,
                        ),
                        child: Text(
                          'Deskripsi: ',
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
                          bottom: 9.0,
                        ),
                        child: Text(
                          'Interior kereta ini kental dengan nuansa budaya Bali. ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: KaiColor.white,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 18.0,
                          right: 18.0,
                        ),
                        child: Text(
                          'Kategori: ',
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
                          bottom: 9.0,
                        ),
                        child: Text(
                          'Ruang VIP, Sajian Makan, Aneka Kudapan, Sajian Minuman, Handuk Wajah, Karaoke, Film/Video, Crew Khusus VIP ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: KaiColor.white,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 18.0,
                          right: 18.0,
                        ),
                        child: Text(
                          'Kisaran Harga:',
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
                          children: const [
                            Text(
                              'Rp 400.000',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
