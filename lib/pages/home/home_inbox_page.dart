import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/providers/home/home_inbox_state.dart';
import 'package:provider/provider.dart';

class HomeInboxPage extends StatefulWidget {
  const HomeInboxPage({
    Key? key,
    this.scaffoldKey,
    this.scrollController,
  }) : super(key: key);
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScrollController? scrollController;

  @override
  _HomeInboxPageState createState() => _HomeInboxPageState();
}

class _HomeInboxPageState extends State<HomeInboxPage> {
  HomeInboxState state = HomeInboxState();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

  Widget buildAccountScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: const Text(''),
        title: const Text(
          'Inbox',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: KaiColor.white,
          ),
        ),
        backgroundColor: KaiColor.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/comments.svg',
              width: MediaQuery.of(context).size.width * 0.35,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18.0, bottom: 10.0),
              child: Text(
                'Belum ada pesan',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Pesan akan muncul secara otomatis pada halaman ini',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
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
    state = Provider.of<HomeInboxState>(context);
    state.init(context, scaffoldKey: widget.scaffoldKey);
    return buildAccountScreen();
  }
}
