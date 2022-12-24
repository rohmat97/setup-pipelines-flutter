import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/values.dart';
import '../../hotel/models/hotel.dart';
import '../../data/models/mice.dart';
import 'mice_detail_page.dart';

class MiceListPage extends StatefulWidget {
  const MiceListPage({
    required this.title,
    Key? key
  }) : super(key: key);

  final String title;

  @override
  State<MiceListPage> createState() => _MiceListPageState();
}

class _MiceListPageState extends State<MiceListPage> {

  @override
  void initState() {
    super.initState();
    //
  }

  List<Mice> miceList = [
    Mice(
      name: 'Nama Room',
      address: 'Jl. Raya Cibeureum No.14, Campaka, Kec. Andir, Kota Bandung, Jawa Barat',
      city: 'Kota Bandung, Jawa Barat',
      price: 2300000,
      rate: 4.8,
      photos: [
        'https://www.bbchotellampung.com/assets/uploads/facilities/20200227094158_mice.jpg',
        'https://cdn-2.tstatic.net/bali/foto/bank/images/meeting-room-di-swiss-belhotel-rainforest-kuta-yang-bisa-digunakan-konferensi-seminar-dan-meeting.jpg',
        'https://venuemagz.com/wp-content/uploads/2017/10/Funtion-Room-Holiday-inn-kemayoran-800x533_c.jpg'
      ],
      capacity: 250
    ),
    for (var i = 2; i <= 10; i++) Mice(
      name: 'Nama Room $i',
      address: 'Jl. Raya Cibeureum No.14, Campaka, Kec. Andir, Kota Bandung, Jawa Barat',
      city: 'Kota Bandung, Jawa Barat',
      price: 2000000 + i*100000,
      rate: 4 + i/10,
      photos: [
        'https://venuemagz.com/wp-content/uploads/2017/10/Funtion-Room-Holiday-inn-kemayoran-800x533_c.jpg',
        'https://www.bbchotellampung.com/assets/uploads/facilities/20200227094158_mice.jpg',
        'https://cdn-2.tstatic.net/bali/foto/bank/images/meeting-room-di-swiss-belhotel-rainforest-kuta-yang-bisa-digunakan-konferensi-seminar-dan-meeting.jpg'
      ],
      capacity: 100 + (i*10)
    )
  ];

  String selectedJenis = 'Wedding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(widget.title.isEmpty ? 'Bandung' : widget.title, style: const TextStyle(
          color: Colors.black
        )),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: MyColors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              // padding: EdgeInsets.only(top: 60),
              child: Container(
                color: MyColors.transparent,
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.only(top: 72, bottom: 24),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var mice in miceList) NewAvicennaContainer(
                      margin: EdgeInsets.only(top: 18),
                      boxShadow: AvicennaProps.boxShadowEqual,
                      padding: EdgeInsets.zero,
                      onTap: () {
                        navigateToPage(context, MiceDetailPage(mice: mice));
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 128,
                            child: AspectRatio(
                              aspectRatio: 0.8, // 1.5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                child: CachedNetworkImage(
                                  imageUrl: mice.photos.first,
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
                              children: [
                                Text(mice.name, style: MyTextStyle.heading1,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                                    Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                                    Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                                    Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                                    Icon(Icons.star, size: 20, color: Colors.grey),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.pin_drop, size: 20, color: Colors.grey),
                                    Text('${mice.capacity} Orang'),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text('Rp${moneyFormat(mice.price)}', style: MyTextStyle.money),
                                Text('/ 5 Jam', style: MyTextStyle.info),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: AvicennaContainer(
                boxShadow: AvicennaProps.boxShadowVerySoft,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.only(top: 12, bottom: 12),
                borderRadius: 0,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  // padding: const EdgeInsets.only(right: 12),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var jenis in ['Wedding', 'Rapat', 'Serbaguna', 'Serbaguna']) NewAvicennaContainer(
                        color: jenis == selectedJenis ? Colors.blue.withOpacity(0.2) : AvicennaColors.white,
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.all(12),
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(jenis, style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                            ))
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            selectedJenis = jenis;
                          });
                        },
                      ),
                      const SizedBox(width: 12),
                    ],
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}