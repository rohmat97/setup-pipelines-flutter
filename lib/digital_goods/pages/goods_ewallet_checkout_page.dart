import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';
import '04goods_pulsa_payment_method_page.dart';

class GoodsEwalletCheckoutPage extends StatefulWidget {
  static const routeName = '/goods-dashboard-pages';

  const GoodsEwalletCheckoutPage({Key? key}) : super(key: key);

  @override
  State<GoodsEwalletCheckoutPage> createState() => _GoodsEwalletCheckoutPageState();
}

class _GoodsEwalletCheckoutPageState extends State<GoodsEwalletCheckoutPage> {
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
                                      Text('Jenis Layanan'),
                                      Text('Topup OVO')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('No. Telepon'),
                                      Text('081213213283'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Nama'),
                                      Text('Balmond'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Nominal'),
                                      Text('Rp100.000'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Biaya Admin'),
                                      Text('Rp2.000'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Tagihan'),
                                      Text('Rp102.000'),
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
                          Text('Rp 102.000', style: MyTextStyle.money),
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