import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/container.dart';
import 'package:kai_wisata/commons/widgets/text.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/commons/widgets/values.dart';

import '../../commons/commons.dart';
import '04goods_pulsa_payment_method_page.dart';

class GoodsHaloCheckoutPage extends StatefulWidget {
  const GoodsHaloCheckoutPage({Key? key}) : super(key: key);

  @override
  State<GoodsHaloCheckoutPage> createState() => _GoodsHaloCheckoutPageState();
}

class _GoodsHaloCheckoutPageState extends State<GoodsHaloCheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Checkout',style: TextStyle(
            color: Colors.black
        )),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: MyColors.white,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvicennaContainer(
                      color: MyColors.background,
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Nomor Telepon'),
                                Text('081282828282')
                              ],
                            ),
                          ),
                          const Divider(thickness: 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Tagihan'),
                                Text('Rp 156.000', style: MyTextStyle.money),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                )
              )
            ),
            Positioned(
              bottom: 0,
              child: AvicennaContainer(
                borderRadius: 0,
                margin: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Tagihan'),
                        Text('Rp 156.000', style: MyTextStyle.money),
                      ]
                    ),
                    const SizedBox(height: 12),
                    NewAvicennaContainer(
                      onTap: () {

                      },
                      color: MyColors.background,
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Icon(Icons.discount),
                          const SizedBox(width: 6),
                          Text('Gunakan Voucher'),
                          new Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    AvicennaButton(
                      text: 'Pilih Pembayaran',
                      onPressed: () {
                        navigateToPage(context, GoodsPulsaPaymentMethodPage(

                        ));
                      },
                    ),
                  ],
                ),
              )
            )
          ],
        )
      )
    );
  }

}