import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/data/constants.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/models/history_payment.dart';
import 'package:kai_wisata/home/providers/home_account_state.dart';
import 'package:kai_wisata/widgets/kai_card.dart';
import 'package:kai_wisata/widgets/kai_last_transaction.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeBookingPage extends StatefulWidget {
  const HomeBookingPage({
    Key? key,
    this.scaffoldKey,
    this.scrollController,
  }) : super(key: key);
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScrollController? scrollController;

  @override
  _HomeBookingPageState createState() => _HomeBookingPageState();
}

class _HomeBookingPageState extends State<HomeBookingPage> {
  HomeAccountState state = HomeAccountState();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

  Widget buildAccountScreen() {
    List<Widget> menu = [];
    for (Map<String, dynamic> item in accountMenu) {
      menu.add(
        Container(
          decoration: const BoxDecoration(
            color: KaiColor.neutral11,
          ),
          child: GestureDetector(
            onTap: () {
              // print(item['onTap']);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: KaiColor.neutral11,
                leading: SvgPicture.asset(
                  item['asset'],
                  height: 20,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: KaiColor.black,
                ),
                title: Text(
                  item['title'],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Padding(
              padding: EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                top: 28.0,
                bottom: 10.0,
              ),
              child: Text(
                'History Transaksi',
                style: KaiTextStyle.bodyLargeBold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 4.5,
              ),
              child: KaiCard(
                onClick: () => state.onHistoryTap(),
                bgColor: KaiColor.neutral11,
                text: 'Kereta Reguler',
                asset: 'assets/svg/ic_train.svg',
                style: KaiTextStyle.bodySmallBold.apply(fontSizeDelta: 1.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 4.5,
              ),
              child: KaiCard(
                onClick: () => state.onTourismHistoryTap(),
                bgColor: KaiColor.neutral11,
                text: 'Kereta Wisata',
                asset: 'assets/svg/ic_train.svg',
                style: KaiTextStyle.bodySmallBold.apply(fontSizeDelta: 1.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 4.5,
              ),
              child: KaiCard(
                onClick: () => state.onSpecialHistoryTap(),
                bgColor: KaiColor.neutral11,
                text: 'Kereta Istimewa',
                asset: 'assets/svg/ic_train.svg',
                style: KaiTextStyle.bodySmallBold.apply(fontSizeDelta: 1.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 4.5,
              ),
              child: KaiCard(
                onClick: () => state.onFlightHistoryTap(),
                bgColor: KaiColor.neutral11,
                text: 'Pesawat',
                asset: 'assets/svg/ic_plane.svg',
                style: KaiTextStyle.bodySmallBold.apply(fontSizeDelta: 1.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 4.5,
              ),
              child: KaiCard(
                onClick: () {},
                bgColor: KaiColor.neutral11,
                text: 'Hotel',
                asset: 'assets/svg/ic_hotel.svg',
                style: KaiTextStyle.bodySmallBold.apply(fontSizeDelta: 1.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 4.5,
              ),
              child: KaiCard(
                onClick: () => state.onDigitalGoodsTap(),
                bgColor: KaiColor.neutral11,
                text: 'Tagihan dll',
                asset: 'assets/svg/ic_rental.svg',
                style: KaiTextStyle.bodySmallBold.apply(fontSizeDelta: 1.0),
              ),
            ),

            // InkWell(
            //   onTap: () => state.onStationTap(),
            //   child: ListTile(
            //     leading: SvgPicture.asset(
            //       'assets/svg/coin.svg',
            //       height: 30,
            //     ),
            //     title: const Text(
            //       '100 Points',
            //       style: TextStyle(
            //         color: KaiColor.blue,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   decoration: const BoxDecoration(
            //     color: KaiColor.white,
            //   ),
            //   alignment: Alignment.topLeft,
            //   child: ListView.builder(
            //     itemCount: menu.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return menu[index];
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<HomeAccountState>(context);
    state.init(context, scaffoldKey: widget.scaffoldKey);

    return buildAccountScreen();
  }
}
