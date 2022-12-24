import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/container.dart';
import 'package:kai_wisata/commons/widgets/text.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/commons/widgets/values.dart';
import 'package:kai_wisata/digital_goods/pages/goods_halo_checkout_page.dart';

import '../../commons/commons.dart';

class GoodsHaloPricePage extends StatefulWidget {
  const GoodsHaloPricePage({Key? key}) : super(key: key);

  @override
  State<GoodsHaloPricePage> createState() => _GoodsHaloPricePageState();
}

class _GoodsHaloPricePageState extends State<GoodsHaloPricePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Tagihan',style: TextStyle(
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
                      boxShadow: AvicennaProps.boxShadowSoftEqual,
                      margin: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Placeholder(fallbackHeight: 36, fallbackWidth: 36),
                          const SizedBox(width: 24),
                          Text('Telkomsel - Halo')
                        ],
                      )
                    ),
                    const Divider(thickness: 2, height: 24),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nomor Telepon'),
                          Text('081282282828'),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1, height: 24),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nama Pelanggan'),
                          Text('Indah'),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1, height: 24),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Periode Tagihan'),
                          Text('Juli 2022'),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1, height: 24),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Tagihan'),
                          Text('Rp 156.000', style: MyTextStyle.money),
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
                child: AvicennaButton(
                  text: 'Lanjut',
                  onPressed: () {
                    navigateToPage(context, GoodsHaloCheckoutPage());
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