import 'package:flutter/material.dart';
import 'package:kai_wisata/digital_goods/pages/goods_bpjs_checkout_page.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/dropdown.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';

class GoodsBpjsHomePage extends StatefulWidget {
  static const routeName = '/goods-dashboard-pages';

  const GoodsBpjsHomePage({Key? key}) : super(key: key);

  @override
  State<GoodsBpjsHomePage> createState() => _GoodsBpjsHomePageState();
}

class _GoodsBpjsHomePageState extends State<GoodsBpjsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('BPJS',style: TextStyle(
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
                        child: Text('Status tagihan BPJS akan diperbarui maksimal 3x24 jam pada hari kerja setelah transaksi berhasil dilakukan'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                AvicennaButton(
                    onPressed: () {
                      navigateToPage(context, GoodsBpjsCheckoutPage());
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