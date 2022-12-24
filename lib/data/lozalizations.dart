// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  // static const _localizedValues = {
  //   'en': {},
  //   'id': {},
  // };
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'id'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class OverrideLocalization extends StatelessWidget {
  const OverrideLocalization({Key? key, this.locale, this.child})
      : super(key: key);
  final Locale? locale;
  final Widget? child;

  @override
  Widget build(BuildContext context) => locale != null
      ? Localizations.override(
          context: context,
          locale: locale,
          child: child!,
        )
      : child!;
}
