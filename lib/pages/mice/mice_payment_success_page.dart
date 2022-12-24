import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../hotel/models/hotel.dart';
import '../../data/models/mice.dart';
import '../home/home_page.dart';
import 'mice_order_detail_page.dart';

class MicePaymentSuccessPage extends StatefulWidget {
  const MicePaymentSuccessPage({
    required this.mice,
    Key? key
  }) : super(key: key);

  final Mice mice;

  @override
  State<MicePaymentSuccessPage> createState() => _MicePaymentSuccessPageState();
}

class _MicePaymentSuccessPageState extends State<MicePaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      // appBar: AppBar(
      //   title: const Text('Pembayaran', style: TextStyle(
      //     color: Colors.black
      //   )),
      //   iconTheme: const IconThemeData(
      //     color: Colors.black,
      //   ),
      //   elevation: 0,
      //   backgroundColor: MyColors.white,
      // ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 48),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: AspectRatio(
                          aspectRatio: 1.6, // 1.5,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: CachedNetworkImage(
                                imageUrl: widget.mice.photos.first,
                                fit: BoxFit.cover,
                                // placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(child: Text('Room telah berhasil dipesan', style: MyTextStyle.heading1)),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nomor Pesanan'),
                        Text('87251936190', style: MyTextStyle.heading2),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tanggal Pemesanan'),
                        Text('15 Juni 2022', style: MyTextStyle.heading2),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tanggal Pembayaran'),
                        Text('15 Juni 2022', style: MyTextStyle.heading2),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Metode Pembayaran'),
                        Flexible(child: Text('Virtual Account Bank Mandiri', style: MyTextStyle.heading2, maxLines: 2, textAlign: TextAlign.end)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Biaya'),
                        Text('Rp${moneyFormat(widget.mice.price + 200000)}', style: MyTextStyle.money),
                      ],
                    ),
                    const Divider(thickness: 2, height: 48),
                    AvicennaContainer(
                      margin: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rincian Pesanan', style: MyTextStyle.heading2),
                          Text('Lihat', style: MyTextStyle.money),
                        ],
                      ),
                      onTap: () {
                        navigateToPage(context, MiceOrderDetailPage(mice: widget.mice));
                      }
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: AvicennaContainer(
                  margin: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  // boxShadow: AvicennaProps.boxShadowEqual,
                  borderRadius: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AvicennaButton(
                            color: MyColors.background2,
                            textColor: MyColors.primary,
                            onPressed: () {
                            }, text: 'Silakan Menghubungi pihak room'),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AvicennaButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HomePage.routeName, (Route<dynamic> route) => false
                              );
                            }, text: 'Kembali Ke Beranda'),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AvicennaButton(
                          color: MyColors.background2,
                          textColor: MyColors.primary,
                          onPressed: () {
                            // navigateToPage(context, HotelRatingPage(hotel: widget.hotel, room: widget.room));
                          }, text: 'Batalkan Pesanan'
                        ),
                      )
                    ],
                  ),
                )
            ),
          ],
        )
      )
    );
  }

}