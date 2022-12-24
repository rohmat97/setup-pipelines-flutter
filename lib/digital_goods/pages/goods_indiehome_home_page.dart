import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/pages/goods_telkom_checkout_page.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';

class GoodsIndiehomeHomePage extends StatefulWidget {
  static const routeName = '/goods-dashboard-pages';

  const GoodsIndiehomeHomePage({Key? key}) : super(key: key);

  @override
  State<GoodsIndiehomeHomePage> createState() => _GoodsIndiehomeHomePageState();
}

class _GoodsIndiehomeHomePageState extends State<GoodsIndiehomeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Indiehome',style: TextStyle(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 24),
            child: Column(
              children: [
                AvicennaTextField(
                  title: 'Nomor Telpon',
                  textFieldStyle: AvicennaTextFieldStyle.border,
                ),
                const SizedBox(height: 12),
                AvicennaContainer(
                  padding: EdgeInsets.all(8),
                  color: Colors.blue.withOpacity(0.2),
                  margin: EdgeInsets.zero,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline),
                      const SizedBox(width: 6),
                      Expanded(
                          child: Column(
                            children: [
                              Text('1. Produk Telkom tidak tersedia pada jam maintenance atau perawatan (23:30 - 01:30)'),
                              Text('2. Transaksi pembayaran tagihan Telkom membutuhkan waktu proses maksimal 2x24 jam'),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                AvicennaButton(
                    onPressed: () {
                      navigateToPage(context, GoodsTelkomCheckoutPage());
                    },
                    text: 'Lanjutkan'
                ),
                const SizedBox(height: 24),
                Text('Transaksi Terakhir')
              ]
            )
          )
        ),
      )
    );
  }

}