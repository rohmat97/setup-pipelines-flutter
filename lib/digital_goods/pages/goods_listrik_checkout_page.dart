import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/commons/widgets/values.dart';
import 'package:kai_wisata/digital_goods/arguments/goods_listrik_home_arguments.dart';
import 'package:kai_wisata/digital_goods/providers/listrik_home_state.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '04goods_pulsa_payment_method_page.dart';
import 'package:provider/provider.dart';
import "../../base_service.dart";

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:kai_wisata/data/cache/hive_repository.dart';

class GoodsListrikCheckoutPage extends StatefulWidget {
  static const routeName = '/goods-checkout-pages';

  const GoodsListrikCheckoutPage({Key? key}) : super(key: key);

  @override
  State<GoodsListrikCheckoutPage> createState() =>
      _GoodsListrikCheckoutPageState();
}

class _GoodsListrikCheckoutPageState extends State<GoodsListrikCheckoutPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  ListrikHomeState state = ListrikHomeState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as GoodsListrikHomeArguments;

    state = Provider.of<ListrikHomeState>(context);
    state.initState(context, scaffoldKey);

    if (args.type == "Tagihan Listrik") {
      state.fetchTagihan(args.nomorMeter);
    }

    return Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          title: const Text('Checkout', style: TextStyle(color: Colors.black)),
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
                    padding: const EdgeInsets.only(
                        top: 24, left: 20, right: 20, bottom: 24),
                    child: Column(children: [
                      AvicennaContainer(
                        color: MyColors.background,
                        margin: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Jenis Layanan'),
                                  Text('Tagihan Listrik')
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('No. Meter'),
                                  Text(args.nomorMeter),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Nama'),
                                  Text("${state.nama}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Biaya Admin'),
                                  Text("Rp. ${state.adm}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tagihan'),
                                  Text("Rp. ${state.tagihanListrik}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))),
            Positioned(
                bottom: 0,
                child: AvicennaContainer(
                  borderRadius: 0,
                  margin: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Tagihan'),
                            Text("Rp. ${state.amountToCharge}",
                                style: MyTextStyle.money),
                          ]),
                      const SizedBox(height: 12),
                      NewAvicennaContainer(
                        onTap: () {},
                        color: MyColors.background,
                        margin: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Icon(Icons.discount),
                            const SizedBox(width: 6),
                            Text('Gunakan Voucher'),
                            new Spacer(),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      AvicennaButton(
                        text: 'Pilih Pembayaran',
                        onPressed: () async {
                          await state.nextStep(args.nomorMeter);
                        },
                      ),
                    ],
                  ),
                ))
          ],
        )));
  }
}
