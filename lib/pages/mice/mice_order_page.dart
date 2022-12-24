import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/checkbox.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/dropdown.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';
import '../../hotel/models/hotel.dart';
import '../../data/models/mice.dart';
import 'mice_additional_page.dart';
import 'mice_checkout_page.dart';

class MiceOrderPage extends StatefulWidget {
  const MiceOrderPage({
    required this.mice,
    Key? key
  }) : super(key: key);

  final Mice mice;

  @override
  State<MiceOrderPage> createState() => _MiceOrderPageState();
}

class _MiceOrderPageState extends State<MiceOrderPage> {
  bool payOnCheckIn = false;

  @override
  void initState() {
    super.initState();
    //
  }

  bool meja = false;
  bool mc = false;
  bool band = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Rincian Pesanan', style: TextStyle(
            color: Colors.black
        )),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: MyColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            color: MyColors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 128,
                      child: AspectRatio(
                        aspectRatio: 1, // 1.5,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CachedNetworkImage(
                              imageUrl: widget.mice.photos.first,
                              fit: BoxFit.cover,
                              // placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 6),
                          Text(widget.mice.name, style: MyTextStyle.heading1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                              Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                              Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                              Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                              Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                              Icon(Icons.star, size: 20, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.pin_drop, size: 20, color: Colors.grey),
                              Text(widget.mice.city),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: AvicennaTextFieldWithPrefix(
                        textFieldStyle: AvicennaTextFieldStyle.border,
                        title: 'Tanggal Reservasi',
                        prefixIcon: Icon(Icons.calendar_month),
                        minusWidth: 203,
                        initialValue: 'Rab, 16 Mar',
                        enabled: false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: AvicennaTextFieldWithPrefix(
                        textFieldStyle: AvicennaTextFieldStyle.border,
                        title: 'Kapasitas',
                        prefixIcon: Icon(Icons.people),
                        minusWidth: 203,
                        initialValue: '1000 Orang',
                        enabled: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AvicennaDropDownPicker(
                  textFieldStyle: AvicennaTextFieldStyle.border,
                  title: 'Jam Kegiatan',
                  initialValue: '07.00 - 11.00 (4 Jam)',
                  onChanged: (val) {  },
                  items: [
                    '07.00 - 11.00 (4 Jam)'
                  ],
                ),
                const Divider(thickness: 2, height: 34),
                Text('Informasi Pemesan', style: MyTextStyle.heading1),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: AvicennaTextField(
                        textFieldStyle: AvicennaTextFieldStyle.border,
                        title: 'Nama Depan',
                        hintText: 'Nama Sesuai KTP',
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: AvicennaTextField(
                        textFieldStyle: AvicennaTextFieldStyle.border,
                        title: 'Nama Belakang',
                        hintText: 'Nama Sesuai KTP',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AvicennaDropDownPicker(
                  textFieldStyle: AvicennaTextFieldStyle.border,
                  title: 'Kewarganegaraan',
                  hint: Text('Pilih Warga Negara'),
                  onChanged: (val) {  },
                  items: [
                    'Indonesia',
                    'WNA',
                  ],
                ),
                const SizedBox(height: 12),
                AvicennaTextField(
                  textFieldStyle: AvicennaTextFieldStyle.border,
                  title: 'Alamat',
                ),
                const SizedBox(height: 12),
                Text('Informasi Kontak', style: MyTextStyle.heading1),
                const SizedBox(height: 12),
                AvicennaTextField(
                  textFieldStyle: AvicennaTextFieldStyle.border,
                  title: 'Email',
                ),
                const SizedBox(height: 12),
                AvicennaTextField(
                  textFieldStyle: AvicennaTextFieldStyle.border,
                  title: 'No. Handphone',
                ),
                const Divider(thickness: 2, height: 40),
                AvicennaContainer(
                  width: MediaQuery.of(context).size.width,
                  color: MyColors.background1,
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text('Tambah Fasilitas Berbayar', style: const TextStyle(
                        fontSize: 16,
                      )),
                      if (meja) Row(
                        children: [
                          Text('Meja Rapat', style: MyTextStyle.heading2),
                          const Spacer(),
                          Text('20.000 / set', style: TextStyle(
                              color: Colors.red
                          )),
                        ],
                      ),
                      if (mc) Row(
                        children: [
                          Text('MC', style: MyTextStyle.heading2),
                          const Spacer(),
                          Text('340.000 / 4 Jam', style: TextStyle(
                              color: Colors.red
                          )),
                        ],
                      ),
                      if (band) Row(
                        children: [
                          Text('Band Music', style: MyTextStyle.heading2),
                          const Spacer(),
                          Text('1.200.000 / Jam', style: TextStyle(
                              color: Colors.red
                          )),
                        ],
                      )
                    ],
                  ),
                  onTap: () async {
                    var result = await navigateToPage(context, const MiceAdditionalPage());
                    if (result != null) {
                      setState(() {
                        meja = result[0];
                        mc = result[1];
                        band = result[2];
                      });
                    }
                  },
                ),
                const Divider(thickness: 2, height: 38),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Total Pembayaran', style: MyTextStyle.info),
                      const SizedBox(height: 14),
                      Text('Rp${moneyFormat(widget.mice.price + 200000)}', style: MyTextStyle.heading1),
                      const SizedBox(height: 4),
                      Text('Dengan pajak Rp${moneyFormat(20500)} dan lainnya', style: MyTextStyle.info),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AvicennaButton(
                    text: 'Pesan',
                    onPressed: () {
                      navigateToPage(context, MiceCheckoutPage(mice: widget.mice));
                    },
                  ),
                )
              ]
            ),
          ),
        )
      )
    );
  }
}