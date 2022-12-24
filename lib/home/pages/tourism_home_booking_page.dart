import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/providers/rail_home_dashboard_state.dart';
import 'package:kai_wisata/home/widgets/kai_booking_card.dart';
import 'package:kai_wisata/widgets/kai_loading_indicator.dart';
import 'package:provider/provider.dart';

import '../providers/tourism_home_dashboard_state.dart';
import '../widgets/tourism_booking_card.dart';

class TourismHomeBookingPage extends StatefulWidget {
  static const routeName = '/tourism-home-booking-page';

  const TourismHomeBookingPage({
    Key? key,
    this.scaffoldKey,
    this.scrollController,
  }) : super(key: key);
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScrollController? scrollController;

  @override
  _TourismHomeBookingPageState createState() => _TourismHomeBookingPageState();
}

class _TourismHomeBookingPageState extends State<TourismHomeBookingPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  TourismHomeDashboardState state = TourismHomeDashboardState();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // _refreshIndicatorKey.currentState.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<TourismHomeDashboardState>(context);
    state.init(context, scaffoldKey: widget.scaffoldKey);
    state.fetchHistories();

    return Scaffold(
        backgroundColor: KaiColor.neutral11,
        body: SafeArea(
            child:
            SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildAppBar(),
                      ...(state.isLoaded ? (buildContent()) : [
                        const KaiLoadingIndicator()
                      ])
                    ],
                  ),
                )
            )));
  }

  Widget buildAppBar() {

    return Container(
      color: KaiColor.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: InkWell(
              child: SvgPicture.asset(
                'assets/svg/arrow_left.svg',
                height: 18,
              ),
              onTap: () => state.onBackButton(),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "History Pemesanan",
                style: KaiTextStyle.titleSmallBold
                    .apply(color: KaiColor.black),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  "Daftar Pemesanan KA Wisata",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 10.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }

  List<Widget> buildContent() {
    return [
      buildTabBar(),
      const SizedBox(height: 30),
      ...(state.filtered.map((p) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
            child:
            GestureDetector(
              onTap: () => state.detailClick(p),
              child : TourismBookingCard(payment: p)
            ),
          )))
    ];
  }

    Widget buildTabBar() {
      List<Widget> widgets = [];
      for (BookingCategory category in state.categoryList) {
        widgets.add(
            GestureDetector(
              // onTap: () { state.setSelectedCategoryId(category.id!);},
              child : Container(
              height: 52,
              width:
              MediaQuery.of(context).size.width / state.categoryList.length,
              decoration: BoxDecoration(
                border: category.id == state.selectedCategoryId
                    ? const Border(
                  bottom: BorderSide(
                    color: KaiColor.blue,
                    width: 2,
                  ),
                )
                    : null,
                color: KaiColor.white,
              ),
              alignment: Alignment.center,
              child: Text(
                category.title!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: category.id == state.selectedCategoryId
                      ? KaiColor.blue
                      : KaiColor.black,
                ),
              ),
            ),
            )
        );
      }
      return Row(children: widgets);
    }

}
