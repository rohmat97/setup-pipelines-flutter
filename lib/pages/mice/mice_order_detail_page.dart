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

class MiceOrderDetailPage extends StatefulWidget {
  const MiceOrderDetailPage({
    required this.mice,
    Key? key
  }) : super(key: key);

  final Mice mice;

  @override
  State<MiceOrderDetailPage> createState() => _MiceOrderDetailPageState();
}

class _MiceOrderDetailPageState extends State<MiceOrderDetailPage> {
  bool payOnCheckIn = false;

  @override
  void initState() {
    super.initState();
    //
  }

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
                      Text(widget.mice.name, style: MyTextStyle.heading1),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.people),
                          const SizedBox(width: 8),
                          Text('${widget.mice.capacity} Kapasitas')
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded),
                          const SizedBox(width: 8),
                          Text('4 Jam')
                        ],
                      ),
                      const Divider(thickness: 2, height: 34),
                      Text('Informasi Tamu', style: MyTextStyle.heading1),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nama Depan'),
                          Text('Popot', style: MyTextStyle.heading2),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nama Belakang'),
                          Text('Kupa', style: MyTextStyle.heading2),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Kewarganegaraan'),
                          Text('Indonesia', style: MyTextStyle.heading2),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Alamat'),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Text('Jln lorem ipsum nomor 212, semarang, indonesia', style: MyTextStyle.heading2, textAlign: TextAlign.end)
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text('Informasi Kontak', style: MyTextStyle.heading1),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email'),
                          const SizedBox(width: 24),
                          Expanded(
                              child: Text('popolkupa@gmail.com', style: MyTextStyle.heading2, textAlign: TextAlign.end)
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('No Handphone'),
                          const SizedBox(width: 24),
                          Expanded(
                              child: Text('081282818282', style: MyTextStyle.heading2, textAlign: TextAlign.end)
                          ),
                        ],
                      ),
                      const Divider(thickness: 2, height: 40),
                      Text('Rincian Harga', style: MyTextStyle.heading1),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Room (4 Jam)'),
                          Text('Rp${moneyFormat(widget.mice.price)}', style: MyTextStyle.heading2)
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Meja Rapat (10 set)'),
                          Text('Rp${moneyFormat(200000)}', style: MyTextStyle.heading2)
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Pembayaran', style: MyTextStyle.heading2),
                          Text('Rp${moneyFormat(widget.mice.price + 200000)}', style: MyTextStyle.heading2)
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AvicennaButton(
                          text: 'Kembali',
                          onPressed: () {
                            Navigator.pop(context);
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