import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/pages/goods_game_price_page.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/menu_bubble.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';

class GoodsGameHomePage extends StatefulWidget {
  const GoodsGameHomePage({Key? key}) : super(key: key);

  @override
  State<GoodsGameHomePage> createState() => _GoodsGameHomePageState();
}

class _GoodsGameHomePageState extends State<GoodsGameHomePage> {

  List<Map<String, dynamic>> menus = [
    {'title': 'Pacman', 'icon': Icon(Icons.sports_baseball)},
    {'title': 'PUBG', 'icon': Icon(Icons.sports_cricket)},
    {'title': 'FF', 'icon': Icon(Icons.sports_cricket)},
    {'title': 'ML', 'icon': Icon(Icons.sports_esports_rounded)},
    {'title': 'Genshin Impact', 'icon': Icon(Icons.sports_esports_rounded)},
    {'title': 'OPM', 'icon': Icon(Icons.sports_baseball)},
    {'title': 'Minecraft', 'icon': Icon(Icons.sports_baseball)},
    {'title': 'Ninja Saga', 'icon': Icon(Icons.sports_esports_rounded)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Beli Voucher Game',style: TextStyle(
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
                Placeholder(fallbackHeight: 100),
                const Divider(thickness: 2, height: 24),
                Text('Top Up Voucher Game'),
                const SizedBox(height: 12),
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
                              navigateToPage(context, GoodsGamePricePage(gameName: menu['title']));
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
                              navigateToPage(context, GoodsGamePricePage(gameName: menu['title']));
                            },
                          ),
                        ],
                      )
                    ],
                  )
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
                        child: Text('Pembelian voucher game diatas hanya menggunakan pembayaran dengan Google Play'),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          )
        )
      )
    );
  }

}