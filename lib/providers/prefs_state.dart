import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:kai_wisata/data/cache/cache.dart';

/// Preferences
class PrefsState with ChangeNotifier {
  PrefsState(int cachedLocale) {
    _localeSelector = cachedLocale;
    _locale = supportedLanguages[_localeSelector];
  }

  // Locale
  static const Map<int, Locale> supportedLanguages = {
    0: Locale('en'),
    1: Locale('id'),
  };

  // The selector value, which maps to supportedLanguages
  int? _localeSelector;
  int get localeSelector => _localeSelector!;
  set localeSelector(int val) {
    assert(val >= 0 && val <= 1);
    _localeSelector = val;
    _locale = supportedLanguages[_localeSelector];
    saveLocalization(_localeSelector.toString());
    notifyListeners();
  }

  Locale? _locale;
  Locale? get locale => _locale;
}
