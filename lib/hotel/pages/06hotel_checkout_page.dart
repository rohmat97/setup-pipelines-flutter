import 'package:flutter/material.dart';
import 'package:kai_wisata/hotel/arguments/hotel_checkout_arguments.dart';
import 'package:kai_wisata/hotel/providers/hotel_checkout_state.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../models/hotel.dart';
import '../models/room.dart';
import 'hotel_payment_page.dart';
import 'hotel_payment_select_page.dart';

class HotelCheckoutPage extends StatefulWidget {
  static const routeName = '/hotel-checkout-page';
  const HotelCheckoutPage({Key? key
  }) : super(key: key);

  @override
  State<HotelCheckoutPage> createState() => _HotelCheckoutPageState();
}

class _HotelCheckoutPageState extends State<HotelCheckoutPage> {

  String _paymentMethod = 'Pilih';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  HotelCheckoutState state = HotelCheckoutState();

  @override
  Widget build(BuildContext context) {

    final args =
    ModalRoute.of(context)!.settings.arguments as HotelCheckoutArguments;

    state = Provider.of<HotelCheckoutState>(context);
    state.initState(context, scaffoldKey, args);

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
                    Text(args.hotel.name, style: MyTextStyle.heading1),
                    const SizedBox(height: 12),
                    Text('${args.room.name} 1x'),
                    const SizedBox(height: 6),
                    Text('Rabu, 16 Maret - Kamis, 17 Maret (1 malam)'),
                    const Divider(thickness: 2, height: 48),
                    Text('Rincian Harga', style: MyTextStyle.heading1),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${args.room.name} 1x (1malam)'),
                        Text('Rp${moneyFormat(args.room.price)}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Pembayaran', style: MyTextStyle.heading2),
                        Text('Rp${moneyFormat(args.room.price)}', style: MyTextStyle.money),
                      ],
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
                          state.onPaymentClick();
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