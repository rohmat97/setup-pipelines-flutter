import 'package:flutter/foundation.dart';

/// App state
class AppState with ChangeNotifier {
  // Splash screen
  bool _showSplash = true;
  bool get showSplash => _showSplash;

  void hideSplash() {
    _showSplash = false;
    notifyListeners();
  }

  void resetSplash() {
    _showSplash = true;
    notifyListeners();
  }
}
