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

class HomeAccountPage extends StatefulWidget {
  const HomeAccountPage({
    Key? key,
    this.scaffoldKey,
    this.scrollController,
  }) : super(key: key);
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScrollController? scrollController;

  @override
  _HomeAccountPageState createState() => _HomeAccountPageState();
}

class _HomeAccountPageState extends State<HomeAccountPage> {
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
            Container(
              decoration: const BoxDecoration(
                color: KaiColor.white,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: CircleAvatar(
                            backgroundColor: KaiColor.blue.withOpacity(0.1),
                            radius: 33.0,
                            child: const Text(
                              'MS',
                              style: TextStyle(
                                color: KaiColor.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user!.fullName,
                              style: KaiTextStyle.bodyLargeBold
                                  .apply(fontSizeDelta: 6),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                state.user!.email,
                                style: KaiTextStyle.bodySmallMedium
                                    .apply(fontSizeDelta: -1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        CircleAvatar(
                          backgroundColor: KaiColor.blue,
                          radius: 15.0,
                          child: Icon(
                            Icons.edit,
                            size: 15.0,
                          ),
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: CircleAvatar(
                            backgroundColor: KaiColor.blue,
                            radius: 15.0,
                            child: Icon(
                              Icons.edit,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(color: KaiColor.black),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 4.5,
              ),
              child: KaiCard(
                onClick: () => state.onHelpTap(),
                bgColor: KaiColor.neutral11,
                text: 'Pusat Bantuan',
                asset: 'assets/svg/ic_help.svg',
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
                text: 'Ganti Password',
                asset: 'assets/svg/ic_lock.svg',
                style: KaiTextStyle.bodySmallBold.apply(fontSizeDelta: 1.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 4.5,
              ),
              child: KaiCard(
                onClick: () {
                  state.logout();
                },
                bgColor: KaiColor.neutral11,
                text: 'Keluar',
                asset: 'assets/svg/ic_out.svg',
                style: KaiTextStyle.bodySmallBold.apply(
                  fontSizeDelta: 1.0,
                  color: KaiColor.red,
                ),
              ),
            ),
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
