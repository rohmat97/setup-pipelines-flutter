import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/hotel/arguments/hotel_room_detail_arguments.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/carousel.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/values.dart';
import '../models/hotel.dart';
import '../models/room.dart';
import '../providers/hotel_room_detail_state.dart';
import '05hotel_order_page.dart';

class HotelRoomDetailPage extends StatefulWidget {
  static const routeName = '/hotel-room-detail-page';

  const HotelRoomDetailPage({
    Key? key
  }) : super(key: key);

  @override
  State<HotelRoomDetailPage> createState() => _HotelRoomDetailPageState();
}

class _HotelRoomDetailPageState extends State<HotelRoomDetailPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  HotelRoomDetailState state = HotelRoomDetailState();

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
    ModalRoute.of(context)!.settings.arguments as HotelRoomDetailArguments;

    state = Provider.of<HotelRoomDetailState>(context);
    state.initState(context, scaffoldKey, args);

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
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  MyCarousel(
                    children: args.room.photos.map((e) =>
                      GestureDetector(
                        onTap: () {
                          // showImageViewer(context, e);
                        },
                        child: Image.network('https://via.placeholder.com/300x200')
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
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(args.room.name, style: MyTextStyle.heading1),
                            Text('Sisa ${args.room.availableRoom} kamar', style: args.room.availableRoom > 2 ? MyTextStyle.info : MyTextStyle.warning),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Icon(Icons.person),
                            SizedBox(width: 8),
                            Text('1 tamu/kamar')
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(Icons.hotel),
                            SizedBox(width: 8),
                            Text('1 ranjang single')
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Fasilitas Kamar', style: MyTextStyle.heading1),
                        const SizedBox(height: 12),
                        Container(height: MediaQuery.of(context).size.height * 0.4,
                          child : ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: args.room.facilites.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(args.room.facilites[index]);
                              }
                          )
                        )
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
                            if (appBarTransparencyRatio == 1) Text(args.room.name, style: MyTextStyle.heading1),
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
                  Positioned(
                    bottom: 0,
                    child: AvicennaContainer(
                      margin: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width,
                      boxShadow: AvicennaProps.boxShadowEqual,
                      borderRadius: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Rp${moneyFormat(args.room.price)}', style: MyTextStyle.heading1),
                              Text('per malam', style: MyTextStyle.info),
                            ],
                          ),
                          AvicennaButton(
                            text: 'Lanjutkan Pemesanan',
                            onPressed: () {
                              state.onOrderClick(args.room);
                            },
                          ),
                        ],
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

  buildFacilities(List<String> facilites) {
    List<Widget> widgets = [];
    for(var facility in facilites){
      widgets.add(const SizedBox(height: 8));
      widgets.add(Row(
        children: [
          const Icon(Icons.home_work_outlined),
          const SizedBox(width: 8),
          Text(facility)
        ],
      ));
    }
    return widgets;
  }
}