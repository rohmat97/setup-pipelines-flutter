import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/carousel.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/widgets.dart';
import '../../data/models/mice.dart';
import 'mice_order_page.dart';

class MiceDetailPage extends StatefulWidget {
  const MiceDetailPage({
    required this.mice,
    Key? key
  }) : super(key: key);

  final Mice mice;

  @override
  State<MiceDetailPage> createState() => _MiceDetailPageState();
}

class _MiceDetailPageState extends State<MiceDetailPage> {

  double appBarTransparencyRatio = 0;
  ScrollController scrollController = ScrollController();
  bool isMarked = false;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset - 40 <= 0) {
        setState(() {
          appBarTransparencyRatio = 0;
        });
        return;
      }
      if (scrollController.offset - 40 > 300) {
        setState(() {
          appBarTransparencyRatio = 1;
        });
        return;
      }
      setState(() {
        appBarTransparencyRatio = (scrollController.offset - 40) / 300;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                MyCarousel(
                  children: widget.mice.photos.map((e) =>
                    GestureDetector(
                      onTap: () {
                        // showImageViewer(context, e);
                      },
                      child: CachedNetworkImage(
                        imageUrl: e,
                        fit: BoxFit.contain,
                        // placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    )
                  ).toList()
                ),
                Container(
                  color: MyColors.transparent,
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  padding: const EdgeInsets.only(top: 24, bottom: 24),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.mice.name, style: MyTextStyle.heading1),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(Icons.pin_drop, size: 20, color: Colors.grey),
                                  Text(widget.mice.city),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Rp${moneyFormat(widget.mice.price)}', style: MyTextStyle.money),
                              Text('/ 5 Jam', style: MyTextStyle.info),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text('Nama Room adalah dnsakfmnkasjfdiasu fb sdb kansmfb kasuhdb f iasubd kasniobfjks osfbs asioubf  asifbasn b'),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            color: Colors.blue.withOpacity(0.3),
                            width: 72,
                            height: 72,
                            child: Icon(Icons.menu, color: Colors.blue),
                          ),Container(
                            color: Colors.blue.withOpacity(0.3),
                            width: 72,
                            height: 72,
                            child: Icon(Icons.movie, color: Colors.blue),
                          ),Container(
                            color: Colors.blue.withOpacity(0.3),
                            width: 72,
                            height: 72,
                            child: Icon(Icons.date_range, color: Colors.blue),
                          ),Container(
                            color: Colors.blue.withOpacity(0.3),
                            width: 72,
                            height: 72,
                            child: Icon(Icons.monitor, color: Colors.blue),
                          ),
                        ],
                      ),
                      const Divider(thickness: 2, height: 48),
                      Text('Fasilitas Room', style: MyTextStyle.heading2),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.fastfood_outlined),
                              const SizedBox(width: 8),
                              Text('Snack')
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.people),
                              const SizedBox(width: 8),
                              Text('250 Orang')
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.wifi),
                          const SizedBox(width: 8),
                          Text('Wi-Fi')
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.monitor),
                          const SizedBox(width: 8),
                          Text('Wi-Fi')
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text('Fasilitas Berbayar', style: MyTextStyle.heading2),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.chair),
                          const SizedBox(width: 8),
                          Text('Meja Rapat'),
                          const Spacer(),
                          Text('20.000 / set', style: TextStyle(
                            color: Colors.red
                          ))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.mic),
                          const SizedBox(width: 8),
                          Text('MC'),
                          const Spacer(),
                          Text('340.000 / 4 Jam', style: TextStyle(
                              color: Colors.red
                          ))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.music_note),
                          const SizedBox(width: 8),
                          Text('Live Band Music'),
                          const Spacer(),
                          Text('1.200.000 / 4 Jam', style: TextStyle(
                              color: Colors.red
                          ))
                        ],
                      ),
                      const Divider(thickness: 2, height: 48),
                      Text('Rating dan review', style: MyTextStyle.heading2),
                      const SizedBox(height: 12),
                      Row(
                        children: const [
                          Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                          Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                          Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                          Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                          Icon(Icons.star, size: 20, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ReviewWidget(name: 'Azriel', content: 'Hotelnya bagus', imageUrl: 'https://img.tek.id/img/content/2019/10/04/21135/begini-gambaran-proses-syuting-avatar-2-OUv6EI6mLH.jpg',),
                      ReviewWidget(name: 'Roni', content: 'Hotelnya wangi wangi aja, kalau mau', imageUrl: 'https://img.tek.id/img/content/2019/10/04/21135/begini-gambaran-proses-syuting-avatar-2-OUv6EI6mLH.jpg',),
                      const Divider(thickness: 2, height: 48),
                      Text('Lokasi', style: MyTextStyle.heading2),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: 1.6, // 1.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CachedNetworkImage(
                              imageUrl: 'https://i.stack.imgur.com/RdkOb.jpg',
                              fit: BoxFit.cover,
                              // placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.pin_drop, size: 20, color: Colors.grey),
                          const SizedBox(width: 6),
                          Flexible(child: Text(widget.mice.address, maxLines: 2)),
                        ],
                      ),
                      const Divider(thickness: 2, height: 48),
                      AvicennaButton(
                        minimumSize: Size(MediaQuery.of(context).size.width, 48),
                        onPressed: () {
                          navigateToPage(context, MiceOrderPage(mice: widget.mice));
                        },
                        text: 'Reservasi Sekarang',
                      ),
                      const SizedBox(height: 12),
                      AvicennaButton(
                        minimumSize: Size(MediaQuery.of(context).size.width, 48),
                        color: Colors.grey,
                        onPressed: () {},
                        text: 'Hubungi Kami'
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: AvicennaContainer(
              color: Colors.white.withOpacity(appBarTransparencyRatio),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.only(left: 12, right: 12, top: 6),
              width: MediaQuery.of(context).size.width,
              borderRadius: 0,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvicennaIconButton(onTap: () {
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios_new), color: Colors.white.withOpacity(appBarTransparencyRatio > 0 ? 0 : 0.8)),
                    if (appBarTransparencyRatio == 1) Text(widget.mice.name, style: MyTextStyle.heading1),
                    Spacer(),
                    AvicennaIconButton(onTap: () {
                      setState(() {
                        isMarked = !isMarked;
                      });
                    }, icon: isMarked ? Icon(Icons.bookmark, color: Color(0xFFFFC940)) : Icon(Icons.bookmark_border), color: Colors.white.withOpacity(appBarTransparencyRatio > 0 ? 0 : 0.8))
                  ],
                ),
              )
            )
          ),
        ],
      ),
    );
  }
}