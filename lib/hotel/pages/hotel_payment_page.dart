import 'package:flutter/material.dart';
import 'package:kai_wisata/hotel/pages/hotel_payment_success_page.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../models/hotel.dart';
import '../models/room.dart';

class HotelPaymentPage extends StatefulWidget {
  const HotelPaymentPage({
    required this.hotel,
    required this.room,
    Key? key
  }) : super(key: key);

  final Hotel hotel;
  final Room room;

  @override
  State<HotelPaymentPage> createState() => _HotelPaymentPageState();
}

class _HotelPaymentPageState extends State<HotelPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        title: const Text('Pembayaran', style: TextStyle(
          color: Colors.black
        )),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: MyColors.white,
      ),
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
                    Text('Lakukan Pembayaran Dalam', style: MyTextStyle.heading2),
                    const SizedBox(height: 12),
                    SizedBox(width: MediaQuery.of(context).size.width),
                    Text('00 : 39 : 12', style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue
                    )),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(Icons.credit_card, color: MyColors.primary),
                    const SizedBox(width: 6),
                    Text('Metode Pembayaran', style: MyTextStyle.heading1),
                  ],
                ),
                const SizedBox(height: 12),
                AvicennaContainer(
                  margin: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Icon(Icons.credit_card, color: MyColors.primary),
                      const SizedBox(width: 6),
                      Text('Virtual Account Bank Mandiri'),
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
                      Text('Pemesanan Hotel'),
                      const SizedBox(height: 6),
                      Text('${widget.room.name} 1x', style: MyTextStyle.heading2),
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
                          Text('Rp${moneyFormat(widget.room.price + 20500)}', style: MyTextStyle.money),
                        ],
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 24),
                Center(child: Text('Lihat Panduan Pembayaran', textAlign: TextAlign.center)),
                const SizedBox(height: 48),
                AvicennaButton(onPressed: () {
                  navigateToPage(context, HotelPaymentSuccessPage(hotel: widget.hotel, room: widget.room));
                }, text: 'Sudah Bayar', minimumSize: Size(48, 36),)
              ],
            ),
          ),
        )
      )
    );
  }

}