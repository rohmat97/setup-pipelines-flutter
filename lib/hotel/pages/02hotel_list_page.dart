import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kai_wisata/hotel/arguments/search_hotel_arguments.dart';
import 'package:kai_wisata/hotel/pages/03hotel_detail_page.dart';
import 'package:kai_wisata/hotel/pages/hotel_filter_page.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/values.dart';
import '../models/hotel.dart';
import '../providers/hotel_list_state.dart';

class HotelListPage extends StatefulWidget {
  static const routeName = '/hotel-list-page';

  const HotelListPage({Key? key}) : super(key: key);

  @override
  State<HotelListPage> createState() => _HotelListPageState();
}

class _HotelListPageState extends State<HotelListPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  HotelListState state = HotelListState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final args =
    ModalRoute.of(context)!.settings.arguments as HotelSearchArguments;

    state = Provider.of<HotelListState>(context);
    state.initState(context, scaffoldKey, args);
    state.getHotels();

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(args.city.name, style: const TextStyle(
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
                padding: const EdgeInsets.only(top: 84, bottom: 24),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.isLoading) const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: CircularProgressIndicator(),
                      )
                    ) else for (var hotel in state.hotels) NewAvicennaContainer(
                      margin: const EdgeInsets.only(top: 18),
                      boxShadow: AvicennaProps.boxShadowEqual,
                      padding: EdgeInsets.zero,
                      onTap: () => state.onDetailClick(hotel),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 144, // 128,
                            child: AspectRatio(
                              aspectRatio: 1, // 0.8, // 1.5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                //child: Image.network(hotel.photos.first)
                                  child: Image.network('https://via.placeholder.com/266x120')
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(hotel.name, style: MyTextStyle.heading1,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Row(
                                  children: [
                                    for (int i = 0; i < hotel.stars; i++) const Icon(Icons.star, size: 20, color: Color(0xFFFFC940))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.pin_drop, size: 20, color: Colors.grey),
                                    Text('${hotel.distance.toStringAsFixed(0)} meter'),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text('Rp${moneyFormat(hotel.lowestPrice)}', style: MyTextStyle.money),
                                Text('Perkamar/malam termasuk pajak', style: MyTextStyle.info),
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
                borderRadius: 0,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AvicennaButton(
                      text: 'Urutkan',
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          barrierColor: Colors.black26,
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) {
                            String? _current;
                            return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState2) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 12, bottom: 24, left: 18, right: 18),
                                  // color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Urutkan Berdasarkan'),
                                          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))
                                        ],
                                      ),
                                      IntrinsicHeight(
                                        child: Column(
                                          children:
                                          ['Popularitas',
                                            'Harga Terendah',
                                            'Harga Tertinggi',
                                            'Rating Tertinggi',
                                            'Jarak Terdekat'
                                          ].map((data) => RadioListTile<String>(
                                            title: Text(data, style: const TextStyle(
                                                fontSize: 16
                                            )),
                                            groupValue: _current,
                                            value: data,
                                            selected: data == _current,
                                            selectedTileColor: MyColors.background,
                                            dense: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            onChanged: (val) {
                                              setState2(() {
                                                _current = data;
                                              });
                                            },
                                          )).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              );
                            });
                          }
                        );
                      },
                    ),
                    const VerticalDivider(thickness: 10, color: Colors.red),
                    AvicennaButton(
                      text: 'Filter',
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        navigateToPage(context, const HotelFilterPage());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}