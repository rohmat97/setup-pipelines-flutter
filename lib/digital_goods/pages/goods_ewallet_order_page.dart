import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/commons/widgets/values.dart';
import 'package:kai_wisata/digital_goods/pages/goods_ewallet_checkout_page.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/menu_bubble.dart';

class GoodsEwalletOrderPage extends StatefulWidget {
  const GoodsEwalletOrderPage({
    Key? key,
    required this.walletName
  }) : super(key: key);

  final String walletName;

  @override
  State<GoodsEwalletOrderPage> createState() => _GoodsEwalletOrderPageState();
}

class _GoodsEwalletOrderPageState extends State<GoodsEwalletOrderPage> {

  List<Map<String, dynamic>> menus = [
    {'title': 'OVO', 'icon': Icon(Icons.sports_baseball)},
    {'title': 'GoPay', 'icon': Icon(Icons.sports_cricket)},
    {'title': 'TapCash', 'icon': Icon(Icons.sports_cricket)},
    {'title': 'DANA', 'icon': Icon(Icons.sports_esports_rounded)},
    {'title': 'LinkAja', 'icon': Icon(Icons.sports_esports_rounded)},
    {'title': 'ShopeePay', 'icon': Icon(Icons.sports_baseball)},
    {'title': 'Sakuku', 'icon': Icon(Icons.sports_baseball)},
    {'title': 'iSaku', 'icon': Icon(Icons.sports_esports_rounded)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(widget.walletName,style: TextStyle(
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
                  title: 'Nomor Telepon',
                  textFieldStyle: AvicennaTextFieldStyle.border,
                ),
                const SizedBox(height: 12),
                AvicennaTextField(
                  title: 'Nominal',
                  textFieldStyle: AvicennaTextFieldStyle.border,
                ),
                const SizedBox(height: 12),
                AvicennaButton(
                  onPressed: () {
                    navigateToPage(context, GoodsEwalletCheckoutPage());
                  },
                  text: 'Lanjutkan'
                )
              ]
            ),
          )
        )
      )
    );
  }

}