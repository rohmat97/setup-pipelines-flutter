import 'package:flutter/material.dart';

class HomeInboxState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  ScrollController? scrollController;
  void init(
    BuildContext ctx, {
    GlobalKey<ScaffoldState>? scaffoldKey,
    ScrollController? scrollController,
  }) {
    context = ctx;
    key = scaffoldKey;
    this.scrollController = scrollController;
  }
}
