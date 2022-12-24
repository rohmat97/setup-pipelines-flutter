import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../hotel/models/hotel.dart';
import '../../data/models/mice.dart';
import '../../hotel/pages/hotel_payment_select_page.dart';
import 'mice_payment_page.dart';

class MiceCheckoutPage extends StatefulWidget {
  const MiceCheckoutPage({
    // required this.hotel,
    required this.mice,
    Key? key
  }) : super(key: key);

  // final Hotel hotel;
  final Mice mice;

  @override
  State<MiceCheckoutPage> createState() => _MiceCheckoutPageState();
}

class _MiceCheckoutPageState extends State<MiceCheckoutPage> {

  String _paymentMethod = 'Pilih';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(
          color: Colors.black
        )),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: MyColors.white,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: 200),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.mice.name, style: MyTextStyle.heading1),
                    const SizedBox(height: 12),
                    Text('${widget.mice.capacity} Kapasitar'),
                    const SizedBox(height: 6),
                    Text('Rabu, 16 Maret (07.00 - 11.00)'),
                    const Divider(thickness: 2, height: 48),
                    Text('Rincian Harga', style: MyTextStyle.heading1),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Room 4 jam'),
                        Text('Rp${moneyFormat(widget.mice.price)}'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Meja Rapat (20 set)'),
                        Text('Rp${moneyFormat(200000)}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Pembayaran', style: MyTextStyle.heading2),
                        Text('Rp${moneyFormat(widget.mice.price + 200000)}', style: MyTextStyle.money),
                      ],
                    ),
                    const Divider(thickness: 2, height: 48),
                    Text('Pilih Metode Pembayaran', style: MyTextStyle.heading1),
                    const SizedBox(height: 12),
                    AvicennaContainer(
                      width: MediaQuery.of(context).size.width,
                      color: MyColors.background1,
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.all(12),
                      child: Text(_paymentMethod, style: const TextStyle(
                        fontSize: 16,
                      )),
                      onTap: () async {
                        var result = await navigateToPage(context, const HotelPaymentSelectPage());
                        if (result != null) {
                          setState(() {
                            _paymentMethod = result;
                          });
                        }
                      },
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
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AvicennaButton(
                        onPressed: () {
                          navigateToPage(context, MicePaymentPage(mice: widget.mice));
                        }, text: 'Bayar Sekarang'),
                    ),
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