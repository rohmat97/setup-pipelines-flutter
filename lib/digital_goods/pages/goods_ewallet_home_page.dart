import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/pages/goods_ewallet_order_page.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/menu_bubble.dart';

class GoodsEwalletHomePage extends StatefulWidget {
  static const routeName = '/goods-dashboard-pages';

  const GoodsEwalletHomePage({Key? key}) : super(key: key);

  @override
  State<GoodsEwalletHomePage> createState() => _GoodsEwalletHomePageState();
}

class _GoodsEwalletHomePageState extends State<GoodsEwalletHomePage> {

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
        title: const Text('Topup E-Wallet',style: TextStyle(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvicennaContainer(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var menu in menus.take(4)) MenuBubble(
                            width: (MediaQuery.of(context).size.width - 80) / 4,
                            title: menu['title'],
                            icon: menu['icon'],
                            onTap: () {
                              navigateToPage(context, GoodsEwalletOrderPage(walletName: menu['title']));
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var menu in menus.skip(4).take(4)) MenuBubble(
                            width: (MediaQuery.of(context).size.width - 80) / 4,
                            title: menu['title'],
                            icon: menu['icon'],
                            onTap: () {
                              navigateToPage(context, GoodsEwalletOrderPage(walletName: menu['title']));
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ),
                const Divider(thickness: 2, height: 24),
                Text('Promo yang tersedia'),
                const SizedBox(height: 12),
                Placeholder(fallbackHeight: 100),
              ]
            ),
          )
        )
      )
    );
  }

}