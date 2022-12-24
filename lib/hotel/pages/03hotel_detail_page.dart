import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/hotel/providers/hotel_detail_state.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/carousel.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/widgets.dart';
import '../arguments/hotel_detail_arguments.dart';
import '../models/hotel.dart';
import '04hotel_room_detail_page.dart';

class HotelDetailPage extends StatefulWidget {
  static const routeName = '/hotel-detail-page';

  const HotelDetailPage({
    Key? key
  }) : super(key: key);

  @override
  State<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  HotelDetailState state = HotelDetailState();

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

    final args =
    ModalRoute.of(context)!.settings.arguments as HotelDetailArguments;

    state = Provider.of<HotelDetailState>(context);
    state.initState(context, scaffoldKey, args);
    state.getRooms();

    return Scaffold(
      backgroundColor: MyColors.white,
      // appBar: AppBar(
      //   title: const Text('Hotel',style: TextStyle(
      //     color: Colors.black
      //   )),
      //   iconTheme: const IconThemeData(
      //     color: Colors.black,
      //   ),
      //   elevation: 0,
      //   backgroundColor: MyColors.white,
      // ),
      body:
      // SafeArea(
      //   child:
        Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  MyCarousel(
                    children: args.hotel.photos.map((e) =>
                      GestureDetector(
                        onTap: () {
                          // showImageViewer(context, e);
                        },
                          child: Image.network('https://via.placeholder.com/266x240')
                        //child: Image.network(e)
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(args.hotel.name, style: MyTextStyle.heading1, maxLines: 2),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(Icons.pin_drop, size: 20, color: Colors.grey),
                                      Text(args.hotel.city.name),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.share))
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(args.hotel.message),
                        const Divider(thickness: 2, height: 48),
                        Text('Rating', style: MyTextStyle.heading2),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            for (int i = 0; i < args.hotel.rate.floor(); i++) const Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                            for (int i = 0; i < 5 - args.hotel.rate.floor(); i++) const Icon(Icons.star, size: 20, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(args.hotel.rate.toStringAsFixed(1)),
                          ],
                        ),
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
                            const Icon(Icons.pin_drop, size: 20, color: Colors.grey),
                            const SizedBox(width: 6),
                            Flexible(child: Text(args.hotel.address, maxLines: 2)),
                          ],
                        ),
                        const Divider(thickness: 2, height: 48),
                        for (var room in state.rooms) RoomWidget(
                          room: room,
                          onPressed: () {
                            state.onRoomClick(room);
                          },
                        ),
                        const Divider(thickness: 2, height: 48),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SafeArea(
            //   child: Stack(
            //     children: [
                  Positioned(
                    top: 0,
                    child: AvicennaContainer(
                      color: Colors.white.withOpacity(appBarTransparencyRatio),
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
                      width: MediaQuery.of(context).size.width,
                      borderRadius: 0,
                      child: SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AvicennaIconButton(onTap: () {
                              Navigator.pop(context);
                            }, icon: const Icon(Icons.arrow_back_ios_new), color: Colors.white.withOpacity(appBarTransparencyRatio > 0 ? 0 : 0.8)),
                            if (appBarTransparencyRatio == 1) Text(args.hotel.name, style: MyTextStyle.heading1),
                            const Spacer(),
                            AvicennaIconButton(onTap: () {
                              setState(() {
                                isMarked = !isMarked;
                              });
                            }, icon: isMarked ? const Icon(Icons.bookmark, color: Color(0xFFFFC940)) : const Icon(Icons.bookmark_border), color: Colors.white.withOpacity(appBarTransparencyRatio > 0 ? 0 : 0.8))
                          ],
                        ),
                      )
                    )
                  ),
            //     ],
            //   ),
            // )
          ],
        ),
      );
    // );
  }
}