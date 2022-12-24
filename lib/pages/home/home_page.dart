import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/pages/home_account_page.dart';
import 'package:kai_wisata/home/pages/rail_home_booking_page.dart';
import 'package:kai_wisata/pages/home/home_dashboard_page.dart';
import 'package:kai_wisata/pages/home/home_inbox_page.dart';
import 'package:kai_wisata/providers/home/home_state.dart';
import 'package:provider/provider.dart';

import '../../home/pages/home_booking_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-pages';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final PageStorageBucket bucket = PageStorageBucket();

  List<Widget> pages = [];
  HomeState state = HomeState();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<HomeState>(context);
    state.init(
      context,
      scaffoldKey: _scaffoldKey,
      scrollController: _scrollController,
    );
    pages = <Widget>[
      HomeDashboardPage(
        key: const PageStorageKey('Explore'),
        scaffoldKey: _scaffoldKey,
        scrollController: _scrollController,
      ),
      HomeBookingPage(
        key: const PageStorageKey('Explore'),
        scaffoldKey: _scaffoldKey,
        scrollController: _scrollController,
      ),
      HomeAccountPage(
        key: const PageStorageKey('Explore'),
        scaffoldKey: _scaffoldKey,
        scrollController: _scrollController,
      ),
    ];
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: KaiColor.homeBackground,
      body: SafeArea(
        child: Center(
          child: PageStorage(
            child: pages.elementAt(state.selectedIndex),
            bucket: bucket,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Image(
              image: AssetImage('assets/images/ic_home.png'),
              color: KaiColor.blue,
            ),
            icon: Image(image: AssetImage('assets/images/ic_home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              image: AssetImage('assets/images/ic_booking.png'),
              color: KaiColor.blue,
            ),
            icon: Image(image: AssetImage('assets/images/ic_booking.png')),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              image: AssetImage('assets/images/ic_account.png'),
              color: KaiColor.blue,
            ),
            icon: Image(image: AssetImage('assets/images/ic_account.png')),
            label: 'Account',
          ),
        ],
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 10, color: KaiColor.blue),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 10,
          color: KaiColor.grey,
        ),
        selectedItemColor: KaiColor.blue,
        unselectedItemColor: KaiColor.grey,
        elevation: 16,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: state.selectedIndex,
        onTap: (index) => state.setSelectedPage(index),
      ),
    );
  }
}
