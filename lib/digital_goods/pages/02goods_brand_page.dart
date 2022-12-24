import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/container.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/digital_goods/arguments/brand_arguments.dart';
import 'package:kai_wisata/digital_goods/arguments/pulsa_home_arguments.dart';
import 'package:kai_wisata/digital_goods/models/brand.dart';
import 'package:kai_wisata/digital_goods/pages/03goods_pulsa_home_page.dart';
import 'package:kai_wisata/digital_goods/pages/04goods_pulsa_payment_method_page.dart';
import 'package:kai_wisata/digital_goods/providers/brand_state.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';

class GoodsBrandPage extends StatefulWidget {
  static const routeName = '/goods-brand-pages';

  const GoodsBrandPage({Key? key}) : super(key: key);

  @override
  State<GoodsBrandPage> createState() => _GoodsBrandPageState();
}

class _GoodsBrandPageState extends State<GoodsBrandPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  BrandState state = BrandState();

  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BrandArguments;
    state = Provider.of<BrandState>(context);
    state.initState(context, scaffoldKey, args);
    state.getBrandByCategory();

    return Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          title: Text(args.category.toUpperCase(),
              style: const TextStyle(color: Colors.black)),
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
          padding:
              const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 24),
          child: Column(children: [
            Column(
              children: [
                for (var brand in state.brands) ...[
                  NewAvicennaContainer(
                      margin: EdgeInsets.zero,
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(brand.brand),
                            ],
                          ),
                          AvicennaButton(
                              minimumSize: const Size(40, 32),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, GoodsPulsaHomePage.routeName,
                                    arguments: PulsaHomeArguments(brand.brand));
                              },
                              text: 'BELI')
                        ],
                      )),
                  const Divider(thickness: 2, height: 2)
                ]
              ],
            )
          ]),
        ))));
  }
}
