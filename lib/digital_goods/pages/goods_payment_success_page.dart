import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/pages/01goods_dashboard_page.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../hotel/models/hotel.dart';

class GoodsPaymentSuccessPage extends StatefulWidget {
  const GoodsPaymentSuccessPage({
    Key? key
  }) : super(key: key);

  @override
  State<GoodsPaymentSuccessPage> createState() => _GoodsPaymentSuccessPageState();
}

class _GoodsPaymentSuccessPageState extends State<GoodsPaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.background,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        Icon(Icons.check, size: 48),
                        const SizedBox(height: 12),
                        Text('Selamat Linda, Pesanan kamu berhasil dibuat!', style: MyTextStyle.heading2),
                        const SizedBox(height: 12),
                        SizedBox(width: MediaQuery.of(context).size.width),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AvicennaContainer(
                      margin: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selesaikan Pembayaran Sebelum'),
                          const SizedBox(height: 6),
                          Text('23 jam 59 menit 03 detik', style: MyTextStyle.heading2),
                          SizedBox(width: MediaQuery.of(context).size.width),
                        ],
                      )
                    ),
                    const SizedBox(height: 12),
                    AvicennaContainer(
                        margin: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width),
                            Text('ID Pembayaran'),
                            const SizedBox(height: 6),
                            Text('UH-789400HUI480', style: MyTextStyle.heading2),
                            const SizedBox(height: 12),
                            Text('Item'),
                            const SizedBox(height: 6),
                            Text('xxxxxx', style: MyTextStyle.heading2),
                            const Divider(thickness: 2, height: 48),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('8804 7829 9812', style: TextStyle(fontSize: 20)),
                                Text('Salin'),
                              ],
                            ),
                            const Divider(thickness: 2, height: 48),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Pembayaran', style: MyTextStyle.heading2),
                                Text('Rp${moneyFormat(20500)}', style: MyTextStyle.money),
                              ],
                            ),
                          ],
                        )
                    ),
                    const SizedBox(height: 24),
                    Center(child: Text('Lihat Panduan Pembayaran', textAlign: TextAlign.center)),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AvicennaButton(onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context) =>
                          const GoodsDashboardPage()),
                                  (Route<dynamic> route) => false
                          );
                        }, text: 'Kembali Ke Beranda'),
                      ],
                    )
                  ],
                ),
              ),
            )
        )
    );
  }

}