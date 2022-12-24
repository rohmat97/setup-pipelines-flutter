import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/container.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/commons/widgets/values.dart';
import 'package:kai_wisata/digital_goods/pages/goods_halo_price_page.dart';

import '../../commons/commons.dart';

class GoodsHaloHomePage extends StatefulWidget {
  static const routeName = '/goods-dashboard-pages';

  const GoodsHaloHomePage({Key? key}) : super(key: key);

  @override
  State<GoodsHaloHomePage> createState() => _GoodsHaloHomePageState();
}

class _GoodsHaloHomePageState extends State<GoodsHaloHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Pasca Bayar',style: TextStyle(
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
                      padding: EdgeInsets.all(8),
                      color: Colors.blue.withOpacity(0.2),
                      margin: EdgeInsets.zero,
                      child: Text('Saat ini transaksi pasca bayar hanya untuk KartuHalo dan Indosat')
                    ),
                    const SizedBox(height: 12),
                    AvicennaTextField(
                      textFieldStyle: AvicennaTextFieldStyle.border,
                      title: 'Nomor Handphone',
                      initialValue: '081282222222',
                    )
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
                child: AvicennaButton(
                  text: 'Lihat Tagihan',
                  onPressed: () {
                    navigateToPage(context, const GoodsHaloPricePage());
                  },
                ),
              )
            )
          ],
        )
      )
    );
  }

}