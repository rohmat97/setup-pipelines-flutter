import 'package:flutter/material.dart';

class OnBoardingState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  ScrollController? scrollController;

  void initState(
      BuildContext ctx,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) {
    context = ctx;
    key = scaffoldKey;
  }

  int selectedIndex = 0;
  void setSelectedPage(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }
}
