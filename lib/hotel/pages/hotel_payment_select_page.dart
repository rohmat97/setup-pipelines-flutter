import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';

class HotelPaymentSelectPage extends StatefulWidget {
  const HotelPaymentSelectPage({
    Key? key
  }) : super(key: key);

  @override
  State<HotelPaymentSelectPage> createState() => _HotelPaymentSelectPageState();
}

class _HotelPaymentSelectPageState extends State<HotelPaymentSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
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
                Text('Pilih Metode Pembayaran', style: MyTextStyle.heading1),
                const SizedBox(height: 12),
                Text('E-Wallet', style: MyTextStyle.heading2),
                for (var wallet in ['Gopay', 'Shopeepay', 'OVO', 'LinkAja']) AvicennaContainer(
                  margin: EdgeInsets.only(top: 6),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  child: Row(
                    children: [
                      Icon(Icons.image, size: 32),
                      const SizedBox(width: 6),
                      Text(wallet),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context, wallet);
                  },
                ),
                const SizedBox(height: 12),
                Text('Virtual Account', style: MyTextStyle.heading2),
                for (var wallet in ['BCA', 'Mandiri', 'BRI', 'BNI']) AvicennaContainer(
                  margin: EdgeInsets.only(top: 6),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  child: Row(
                    children: [
                      Icon(Icons.image, size: 32),
                      const SizedBox(width: 6),
                      Text(wallet),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context, wallet);
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

}