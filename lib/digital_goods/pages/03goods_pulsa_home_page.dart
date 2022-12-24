import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/container.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/digital_goods/arguments/pulsa_confirmation_arguments.dart';
import 'package:kai_wisata/digital_goods/arguments/pulsa_home_arguments.dart';
import 'package:kai_wisata/digital_goods/pages/04goods_pulsa_payment_method_page.dart';
import 'package:kai_wisata/digital_goods/providers/pulsa_home_state.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';
import '../../helpers/theme.dart';

class GoodsPulsaHomePage extends StatefulWidget {
  static const routeName = '/goods-pulsa-home';

  const GoodsPulsaHomePage({Key? key}) : super(key: key);

  @override
  State<GoodsPulsaHomePage> createState() => _GoodsPulsaHomePageState();
}

class _GoodsPulsaHomePageState extends State<GoodsPulsaHomePage> with TickerProviderStateMixin {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PulsaHomeState state = PulsaHomeState();

  late TabController _controller;
  int _selectedIndex = 0;

  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as PulsaHomeArguments;
    state = Provider.of<PulsaHomeState>(context);
    state.initState(context, scaffoldKey, args);
    state.getProductByBrand();

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title:  Text('${args.brand}', style: const TextStyle(
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
                const Placeholder(fallbackHeight: 100),
                const Divider(thickness: 2, height: 24),
                AvicennaTextField(
                  title: 'Nomor Handphone',
                  controller: phoneController,
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    for (var product in state.products) ...[
                      NewAvicennaContainer(
                        margin: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.code, style: KaiTextStyle.bodySmallBold,),
                                Text(product.name, style: KaiTextStyle.smallRegular,),
                                AvicennaButton(
                                    minimumSize: const Size(40, 32),
                                    onPressed: (){
                                      Navigator.pushNamed(context!,
                                          GoodsPulsaPaymentMethodPage.routeName,
                                          arguments: PulsaConfirmationArguments(
                                              state.brand,
                                              product,
                                              phoneController.text
                                          )
                                      );
                                    },
                                    text: 'Rp${moneyFormat(product.price.toDouble())}'
                                )
                              ],
                            ),

                          ],
                        )
                      ),
                      const Divider(thickness: 2, height: 2)
                    ]
                  ],
                )
              ]
            ),
          )
        )
      )
    );
  }

}