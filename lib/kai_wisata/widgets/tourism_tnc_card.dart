import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';

import 'package:intl/intl.dart';

class TourismTNCCard extends StatelessWidget {
  const TourismTNCCard({
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
          left: 18.0,
          right: 18.0,
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
                  bottom: 9.0,
                ),
                child: RichText(
                  text: const TextSpan(
                    text:
                        'Dengan ini saya setuju dan mematuhi syarat dan ketentuan pemesanan ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'PT Kereta Api Indonesia (Persero) ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: KaiColor.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'termasuk pembayaran dan mematuhi semua peraturan dan batasan mengenai ketersediaan tarif atau layanan.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                ),
                child: Divider(
                  color: KaiColor.black,
                  thickness: 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 18.0,
                ),
                child: RichText(
                  text: const TextSpan(
                    text: 'Saya telah membaca dan setuju terhadap ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: KaiColor.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Syarat dan Ketentuan pembelian tiket',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: KaiColor.black,
                        ),
                      ),
                    ],
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
