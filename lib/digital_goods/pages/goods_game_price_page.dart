import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/menu_bubble.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';
import '04goods_pulsa_payment_method_page.dart';

class GoodsGamePricePage extends StatefulWidget {
  const GoodsGamePricePage({
    Key? key,
    required this.gameName
  }) : super(key: key);

  final String gameName;

  @override
  State<GoodsGamePricePage> createState() => _GoodsGamePricePageState();
}

class _GoodsGamePricePageState extends State<GoodsGamePricePage> {

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
        title: Text('Voucher ${widget.gameName}',style: TextStyle(
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
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('Powered by'),
                    Icon(Icons.play_arrow),
                    Text('Google Play')
                  ],
                ),
                const Divider(thickness: 2, height: 24),
                Text('Pilih Jumlah Item'),
                const SizedBox(height: 12),
                for (var i = 0; i < 10; i++) ...[
                  NewAvicennaContainer(
                      margin: EdgeInsets.zero,
                      onTap: () {
                        navigateToPage(context, GoodsPulsaPaymentMethodPage(
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${5+(i*4)} Diamond'),
                                Text('${widget.gameName} ${5+(i*4)} Diamond', overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          AvicennaButton(
                              minimumSize: Size(40, 32),
                              onPressed: (){},
                              text: 'Rp${30+(i*3)}.100'
                          )
                        ],
                      )
                  ),
                  const Divider(thickness: 2, height: 2)
                ]
              ]
            ),
          )
        )
      )
    );
  }

}