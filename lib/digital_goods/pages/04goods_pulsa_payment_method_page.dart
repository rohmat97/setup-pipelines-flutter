import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/button.dart';
import 'package:kai_wisata/commons/widgets/container.dart';
import 'package:kai_wisata/commons/widgets/text_field.dart';
import 'package:kai_wisata/digital_goods/arguments/pulsa_confirmation_arguments.dart';
import 'package:kai_wisata/digital_goods/pages/goods_payment_success_page.dart';
import 'package:kai_wisata/digital_goods/providers/pulsa_confirmation_state.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/text.dart';

class GoodsPulsaPaymentMethodPage extends StatefulWidget {
  static const routeName = '/goods-pulsa-confirmation-pages';
  
  const GoodsPulsaPaymentMethodPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GoodsPulsaPaymentMethodPage> createState() => _GoodsPulsaPaymentMethodPageState();
}

class _GoodsPulsaPaymentMethodPageState extends State<GoodsPulsaPaymentMethodPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PulsaConfirmationState state = PulsaConfirmationState();

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as PulsaConfirmationArguments;
    state = Provider.of<PulsaConfirmationState>(context);
    state.initState(context, scaffoldKey, args);

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Pembayaran',style: TextStyle(
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
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Detail Transaksi', style: KaiTextStyle.titleSmallBold,),
                    const SizedBox(height: 12),
                    AvicennaContainer(
                      color: MyColors.background,
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(args.product.code, overflow: TextOverflow.ellipsis,)),
                                Text(args.product.name)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Harga Item'),
                                Text('Rp${moneyFormat(args.product.price.toDouble())}')
                              ],
                            ),
                          ),
                          const Divider(thickness: 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total'),
                                Text('Rp${moneyFormat(args.product.price.toDouble())}', style: KaiTextStyle.titleSmallBold,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              )
            ),
            Positioned(
              bottom: 0,
              child: AvicennaContainer(
                borderRadius: 0,
                margin: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text('Total Tagihan', style: KaiTextStyle.titleSmallThin,),
                        Text('Rp${moneyFormat(args.product.price.toDouble())}', style: KaiTextStyle.titleBigBold,),
                      ],
                    ),
                    AvicennaButton(
                      text: 'Bayar',
                      onPressed: () {
                        state.confirm();
                      },
                    ),
                  ],
                ),
              )
            )
          ],
        )
      )
    );
  }

}