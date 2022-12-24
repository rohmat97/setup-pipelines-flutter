import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/menu_bubble.dart';
import 'package:kai_wisata/commons/widgets/text.dart';
import 'package:kai_wisata/commons/widgets/values.dart';
import 'package:kai_wisata/commons/widgets/widgets.dart';
import 'package:kai_wisata/digital_goods/pages/02goods_brand_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_bpjs_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_ewallet_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_game_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_halo_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_listrik_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_pdam_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_telkom_home_page.dart';
import 'package:kai_wisata/digital_goods/providers/goods_home_state.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/models/history_payment.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/container.dart';
import '../arguments/brand_arguments.dart';
import 'goods_history_page.dart';
import 'goods_indiehome_home_page.dart';
import '03goods_pulsa_home_page.dart';

class GoodsDashboardPage extends StatefulWidget {
  static const routeName = '/goods-dashboard-pages';

  const GoodsDashboardPage({Key? key}) : super(key: key);

  @override
  State<GoodsDashboardPage> createState() => _GoodsDashboardPageState();
}

class _GoodsDashboardPageState extends State<GoodsDashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GoodsHomeState state = GoodsHomeState();

  @override
  void initState() {
    super.initState();
  }

  List<Map<String, dynamic>> menus = [
    {
      'title': 'Pulsa & Data',
      'icon': Icon(Icons.wifi),
      'category': "pulsa/data",
      'destination': const GoodsBrandPage()
    },
    {
      'title': 'Listrik PLN',
      'icon': Icon(Icons.wifi),
      'category': "listrik pln",
      'destination': const GoodsListrikHomePage()
    },
    {
      'title': 'BPJS Kesehatan',
      'icon': Icon(Icons.health_and_safety),
      'category': "bpjs kesehatan",
      'destination': const GoodsBpjsHomePage()
    },
    {
      'title': 'Kartu Halo',
      'icon': Icon(Icons.sim_card),
      'category': "kartu halo",
      'destination': const GoodsHaloHomePage()
    },
    {
      'title': 'Telkom',
      'icon': Icon(Icons.phone),
      'category': "telkom",
      'destination': const GoodsTelkomHomePage()
    },
    {
      'title': 'Indiehome',
      'icon': Icon(Icons.phone),
      'category': "indihome",
      'destination': const GoodsIndiehomeHomePage()
    },
    {
      'title': 'Voucher Game',
      'icon': Icon(Icons.videogame_asset),
      'category': "voucher game",
      'destination': const GoodsPdamHomePage()
    },
    {
      'title': 'eMoney',
      'icon': Icon(Icons.attach_money),
      'category': "emoney",
      'destination': const GoodsEwalletHomePage()
    },
  ];

  @override
  Widget build(BuildContext context) {
    state = Provider.of<GoodsHomeState>(context);
    state.initState(context, scaffoldKey);
    state.getTransactionHistories();

    return Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          title: const Text('Tagihan & Hiburan',
              style: TextStyle(color: KaiColor.white)),
          iconTheme: const IconThemeData(
            color: KaiColor.white,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: KaiColor.blue,
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              color: KaiColor.blue,
              height: 100,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 20, right: 20, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvicennaContainer(
                        // margin: const EdgeInsets.only(top: 24, bottom: 20, left: 20, right: 20),
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        boxShadow: AvicennaProps.boxShadowEqual,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (var menu in menus.take(4))
                                  MenuBubble(
                                    width: (MediaQuery.of(context).size.width -
                                            80) /
                                        4,
                                    title: menu['title'],
                                    icon: menu['icon'],
                                    onTap: () {
                                      if (menu['title'] == 'Listrik PLN') {
                                        Navigator.pushNamed(context,
                                            GoodsListrikHomePage.routeName,
                                            arguments: BrandArguments(
                                                menu["category"]));
                                      }
                                    },
                                  )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (var menu in menus.skip(4).take(3))
                                  MenuBubble(
                                    width: (MediaQuery.of(context).size.width -
                                            80) /
                                        4,
                                    title: menu['title'],
                                    icon: menu['icon'],
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, GoodsBrandPage.routeName,
                                          arguments:
                                              BrandArguments(menu["category"]));
                                    },
                                  ),
                                MenuBubble(
                                  width:
                                      (MediaQuery.of(context).size.width - 80) /
                                          4,
                                  title: 'Lainnya',
                                  icon: const Icon(Icons.menu),
                                  onTap: () {
                                    showAvicennaDialog(
                                      context: context,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            AvicennaContainer(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 24),
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 20,
                                                  bottom: 20),
                                              child: IntrinsicHeight(
                                                  child: Column(
                                                children: [
                                                  const Text('Pilih Layanan',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black)),
                                                  const SizedBox(height: 24),
                                                  Wrap(
                                                    runSpacing: 12,
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      for (var menu in menus)
                                                        MenuBubble(
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  80) /
                                                              4,
                                                          title: menu['title'],
                                                          icon: menu['icon'],
                                                          onTap: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                GoodsBrandPage
                                                                    .routeName,
                                                                arguments:
                                                                    BrandArguments(
                                                                        menu[
                                                                            "category"]));
                                                          },
                                                        )
                                                    ],
                                                  )
                                                ],
                                              )),
                                            )
                                          ]),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        )),
                    const SizedBox(height: 24),
                    const Text('Riwayat Transaksi'),
                    const SizedBox(height: 12),
                    for (var trans in state.histories.take(5))
                      AvicennaContainer(
                        margin: const EdgeInsets.only(bottom: 6),
                        color: MyColors.background,
                        child: Row(
                          children: [
                            const Icon(Icons.sim_card),
                            const SizedBox(width: 6),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat('dd MMM yyyy')
                                    .format(trans.transactionDate)),
                                Text(
                                  trans.description,
                                  maxLines: 2,
                                ),
                              ],
                            )),
                            const SizedBox(width: 20),
                            Text(trans.status.display,
                                style: TextStyle(
                                    color: trans.status.color,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    NewAvicennaContainer(
                      margin: const EdgeInsets.only(top: 6),
                      onTap: () {
                        navigateToPage(
                            context, GoodsHistoryPage(state.histories));
                      },
                      color: MyColors.background1,
                      child: Center(
                        child: Text('Lihat Semua Transaksi',
                            style: MyTextStyle.heading2),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
