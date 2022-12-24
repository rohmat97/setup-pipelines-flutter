import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';

class HotelFilterPage extends StatefulWidget {
  const HotelFilterPage({
    Key? key
  }) : super(key: key);

  @override
  State<HotelFilterPage> createState() => _HotelFilterPageState();
}

class _HotelFilterPageState extends State<HotelFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Filter', style: TextStyle(
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
          child: Column(
            children: [
              AvicennaContainer(
                color: MyColors.background1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Harga', style: MyTextStyle.heading2),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AvicennaContainer(color: MyColors.secondary.withOpacity(0.2), child: Center(child: Text('< Rp 500 rb')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                        const Spacer(),
                        AvicennaContainer(child: Center(child: Text('Rp 500 rb - Rp 1 jt')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AvicennaContainer(child: Center(child: Text('Rp 1 jt - Rp 3 jt')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                        const Spacer(),
                        AvicennaContainer(child: Center(child: Text('> Rp 3 jt')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                      ],
                    ),
                  ]
                )
              ),
              AvicennaContainer(
                color: MyColors.background1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Peringkat Bintang Hotel', style: MyTextStyle.heading2),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 1; i <= 5; i++) AvicennaContainer(
                          color: i == 5 ? MyColors.secondary.withOpacity(0.2) : MyColors.white,
                          child: Row(
                            children: [
                              Text('$i'),
                              const SizedBox(width: 2),
                              Icon(Icons.star, size: 20)
                            ],
                          ),
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.all(12),
                        ),
                      ],
                    ),
                  ]
                )
              ),
              AvicennaContainer(
                color: MyColors.background1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Skor Ulasan Hotel', style: MyTextStyle.heading2),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AvicennaContainer(child: Center(child: Text('Oke: < 6')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                        const Spacer(),
                        AvicennaContainer(child: Center(child: Text('Baik: 6 - 6,9')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AvicennaContainer(color: MyColors.secondary.withOpacity(0.2), child: Center(child: Text('Very Good: 7 - 7.9')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                        const Spacer(),
                        AvicennaContainer(child: Center(child: Text('Luar Biasa: 8 - 10')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                      ],
                    ),
                  ]
                )
              ),
              AvicennaContainer(
                color: MyColors.background1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lokasi', style: MyTextStyle.heading2),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AvicennaContainer(child: Center(child: Text('Kota Bandung')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                        const Spacer(),
                        AvicennaContainer(child: Center(child: Text('Kabupaten Bandung')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AvicennaContainer(child: Center(child: Text('Surabaya')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                        const Spacer(),
                        AvicennaContainer(child: Center(child: Text('Semarang')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Center(child: Text('Tampilkan Lainnya >'))
                  ]
                )
              ),
              AvicennaContainer(
                color: MyColors.background1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis Akomodasi', style: MyTextStyle.heading2),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AvicennaContainer(child: Center(child: Text('Hotel')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                        const Spacer(),
                        AvicennaContainer(child: Center(child: Text('Vila')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AvicennaContainer(child: Center(child: Text('Homestay')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                        const Spacer(),
                        AvicennaContainer(child: Center(child: Text('Apartemen')), margin: EdgeInsets.zero, width: MediaQuery.of(context).size.width / 2 - 36),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Center(child: Text('Tampilkan Lainnya >'))
                  ]
                )
              ),
              AvicennaContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvicennaButton(
                      color: MyColors.background2,
                      textColor: MyColors.primary,
                      onPressed: () {

                      }, text: 'Reset'
                    ),
                    AvicennaButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, text: 'Terapkan'
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}