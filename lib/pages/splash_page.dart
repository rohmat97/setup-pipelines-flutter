import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:kai_wisata/providers/splash_state.dart';
import 'package:kai_wisata/user/models/auth_cache.dart';
import 'package:kai_wisata/user/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash-pages';

  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SplashState state = SplashState();

  int? isviewed;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      'assets/kawisata_new.mp4',
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);

    _playVideo();
  }

  void _playVideo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isviewed = prefs.getInt('onBoard');
    // playing video
    _controller.play();

    // navigating to home screen
    Timer(
      const Duration(seconds: 3), () async {
        // String token = AuthCache.instance.getToken();
        // print(token);
        if (isviewed != 0) {
          state.onFinishFetching();
        } else {
          if (await state.getUser()) {
            await Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (Route<dynamic> route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginPage.routeName,
              (Route<dynamic> route) => false,
            );
          }
        }
      }
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<SplashState>(context);
    state.initState(context, scaffoldKey);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
            : Container(),
      ),
    );
  }
}
