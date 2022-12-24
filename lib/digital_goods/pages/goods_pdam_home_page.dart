import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/dropdown.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';
import 'goods_pdam_checkout_page.dart';

class GoodsPdamHomePage extends StatefulWidget {
  static const routeName = '/goods-dashboard-pages';

  const GoodsPdamHomePage({Key? key}) : super(key: key);

  @override
  State<GoodsPdamHomePage> createState() => _GoodsPdamHomePageState();
}

class _GoodsPdamHomePageState extends State<GoodsPdamHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('PDAM',style: TextStyle(
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
                AvicennaDropDownPicker(
                  title: 'Wilayah',
                  items: ['Jawa Barat', 'DKI Jakarta', 'Banten'],
                  onChanged: (val) {

                  },
                  textFieldStyle: AvicennaTextFieldStyle.border,
                ),
                const SizedBox(height: 12),
                AvicennaTextField(
                  title: 'Nomor Pelanggan',
                  textFieldStyle: AvicennaTextFieldStyle.border,
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
                        child: Text('Transaksi Pembayaran tagihan Air PDAM membutuhkan proses maksimal 1x24 jam pada hari kerja'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                AvicennaButton(
                    onPressed: () {
                      navigateToPage(context, GoodsPdamCheckoutPage());
                    },
                    text: 'Lanjutkan'
                ),
              ]
            )
          )
        ),
      )
    );
  }

}
