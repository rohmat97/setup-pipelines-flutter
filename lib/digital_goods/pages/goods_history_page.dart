import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/menu_bubble.dart';
import 'package:kai_wisata/commons/widgets/values.dart';
import 'package:kai_wisata/commons/widgets/widgets.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/digital_goods/pages/goods_bpjs_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_ewallet_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_game_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_halo_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_listrik_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_pdam_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_telkom_home_page.dart';
import 'package:kai_wisata/home/models/history_payment.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import 'goods_indiehome_home_page.dart';
import '03goods_pulsa_home_page.dart';
import 'package:intl/intl.dart';

class GoodsHistoryPage extends StatefulWidget {
  static const routeName = '/goods-dashboard-pages';
  final List<Transaction> histories;
  const GoodsHistoryPage(this.histories, {Key? key}) : super(key: key);

  @override
  State<GoodsHistoryPage> createState() => _GoodsHistoryPageState();
}

class _GoodsHistoryPageState extends State<GoodsHistoryPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Riwayat Transaksi',style: TextStyle(
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
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 24 + 32, left: 20, right: 20, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var trans in widget.histories) AvicennaContainer(
                      margin: const EdgeInsets.only(bottom: 6),
                      color: MyColors.background,
                      child: Row(
                        children: [
                          const Icon(Icons.sim_card),
                          const SizedBox(width: 6),
                          Expanded(child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('dd MMM yyyy').format(trans.transactionDate)),
                              Text(trans.description,
                                maxLines: 2,),

                            ],
                          )),
                          const SizedBox(width: 20),
                          Text(trans.status.display, style: TextStyle(
                              color: trans.status.color,
                              fontWeight: FontWeight.w600
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                children: [
                  AvicennaButton(
                    minimumSize: Size(40, 28),
                    text: 'Filter',
                    onPressed: () {

                    },
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }

}
