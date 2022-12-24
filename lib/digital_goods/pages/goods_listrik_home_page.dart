import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/commons/widgets/values.dart';
import 'package:kai_wisata/digital_goods/pages/goods_listrik_checkout_page.dart';
import 'package:kai_wisata/digital_goods/arguments/goods_listrik_home_arguments.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/container.dart';

class GoodsListrikHomePage extends StatefulWidget {
  static const routeName = '/goods-listrik-home-pages';

  const GoodsListrikHomePage({Key? key}) : super(key: key);

  @override
  State<GoodsListrikHomePage> createState() => _GoodsListrikHomePageState();
}

class _GoodsListrikHomePageState extends State<GoodsListrikHomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final noMeterPrepaidController = TextEditingController();
  final nominalPrepaidController = TextEditingController();
  final noMeterPostpaidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    noMeterPrepaidController.dispose();
    nominalPrepaidController.dispose();
    noMeterPostpaidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Listrik PLN', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: MyColors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(text: 'Token Listrik'),
            Tab(text: 'Tagihan Listrik'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 24, left: 20, right: 20, bottom: 24),
                  child: Column(children: [
                    AvicennaTextField(
                        title: 'No. Meter',
                        textFieldStyle: AvicennaTextFieldStyle.border,
                        controller: noMeterPrepaidController),
                    const SizedBox(height: 12),
                    AvicennaTextField(
                        title: 'Nominal',
                        textFieldStyle: AvicennaTextFieldStyle.border,
                        controller: nominalPrepaidController),
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
                              child: Text(
                                  'Pembelian token prabayar yang dilakukan antara pukul 23:30 - 00:59 WIB akan diproses setelah pukul 01:00 WIB dikarenakan oleh jadwal offline server PLN')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    AvicennaButton(
                        onPressed: () {
                          // state.checkout();

                          navigateToPage(context, GoodsListrikCheckoutPage());
                        },
                        text: 'Lanjutkan'),
                    const SizedBox(height: 24),
                    Text('Transaksi Terakhir')
                  ]))),
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 24, left: 20, right: 20, bottom: 24),
                  child: Column(children: [
                    AvicennaTextField(
                        title: 'No. Meter',
                        textFieldStyle: AvicennaTextFieldStyle.border,
                        controller: noMeterPostpaidController),
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
                              child: Text(
                                  'Pembelian token prabayar yang dilakukan antara pukul 23:30 - 00:59 WIB akan diproses setelah pukul 01:00 WIB dikarenakan oleh jadwal offline server PLN')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    AvicennaButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, GoodsListrikCheckoutPage.routeName,
                              arguments: GoodsListrikHomeArguments(
                                  noMeterPostpaidController.text,
                                  0,
                                  'Tagihan Listrik'));
                        },
                        text: 'Lanjutkan'),
                    const SizedBox(height: 24),
                    Text('Transaksi Terakhir')
                  ]))),
        ],
      ),
      // SafeArea(
      //   child: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 24),
      //       child: Column(
      //         children: [
      //           AvicennaTextField(
      //             title: 'No. Meter',
      //             textFieldStyle: AvicennaTextFieldStyle.filled,
      //           ),
      //           const SizedBox(height: 12),
      //           AvicennaTextField(
      //             title: 'Nominal',
      //             textFieldStyle: AvicennaTextFieldStyle.filled,
      //           )
      //         ]
      //       )
      //     )
      //   )
      // )
    );
  }
}
