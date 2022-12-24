// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/my_points_state.dart';
import 'package:kai_wisata/widgets/kai_card.dart';
import 'package:kai_wisata/widgets/kai_last_transaction.dart';
import 'package:kai_wisata/widgets/kai_points.dart';
import 'package:provider/provider.dart';
// import 'package:kai_wisata/pages/my_points_history_page.dart';

class MyPointsPage extends StatefulWidget {
  static const routeName = '/my-points-pages';

  const MyPointsPage({Key? key}) : super(key: key);

  @override
  State<MyPointsPage> createState() => _MyPointsPageState();
}

class _MyPointsPageState extends State<MyPointsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  MyPointsState state = MyPointsState();

  bool isEmailValid = true;

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    state = Provider.of<MyPointsState>(context);
    state.initState(context, scaffoldKey);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: KaiColor.black,
            size: 40.0,
          ),
          onPressed: () => state.onBackButton(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text(
          'MyPoints',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: KaiColor.black,
          ),
        ),
        backgroundColor: KaiColor.white,
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: KaiColor.white,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/coin.svg",
                              height: 35.0,
                            ),
                            Text(
                              ' 100',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' pts',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: KaiColor.grey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Earn More Points ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: KaiColor.blue,
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/svg/arrow.svg",
                                height: 12.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: KaiColor.homeBackground,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 18.0,
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: Card(
                                color: KaiColor.white,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 10.0,
                                            left: 10.0,
                                          ),
                                          child: Text(
                                            'Ways to Earn Points',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 10.0,
                                            right: 8.0,
                                          ),
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: KaiColor.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: const [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          KaiPoints(
                                            text: 'Convert Your Points',
                                            bgColor: KaiColor.blue,
                                            txtColor: KaiColor.homeBackground,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          KaiPoints(
                                            text: 'Apply for Various Products',
                                            bgColor: KaiColor.blue,
                                            txtColor: KaiColor.homeBackground,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          KaiPoints(
                                            text: 'Shop & Earns',
                                            bgColor: KaiColor.blue,
                                            txtColor: KaiColor.homeBackground,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          KaiPoints(
                                            text: 'Shop & Earns',
                                            bgColor: KaiColor.blue,
                                            txtColor: KaiColor.homeBackground,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          KaiPoints(
                                            text: 'Shop & Earns',
                                            bgColor: KaiColor.blue,
                                            txtColor: KaiColor.homeBackground,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 18.0,
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: Column(
                            children: [
                              KaiCard(
                                onClick: () {},
                                bgColor: KaiColor.neutral11,
                                text: 'See Points History',
                                asset: 'assets/svg/ic_online.svg',
                                style: KaiTextStyle.bodySmallBold
                                    .apply(fontSizeDelta: 1.0),
                              ),
                              KaiLastTransaction(
                                onClick: () {},
                                title: 'Tiket Kereta Api Gmb - BD',
                                subtitle: '18 Maret 2022',
                                status: 'Berhasil',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
