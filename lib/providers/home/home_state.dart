import 'package:flutter/material.dart';

class HomeState with ChangeNotifier {
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

  int selectedIndex = 0;
  void setSelectedPage(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }
}
