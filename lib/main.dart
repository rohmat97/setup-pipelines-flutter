import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kai_wisata/app.dart';
import 'package:kai_wisata/data/cache/cache.dart';
import 'package:kai_wisata/data/config.dart';
import 'package:kai_wisata/kai_reguler/models/caches/station_caches.dart';
import 'package:kai_wisata/kai_reguler/providers/regular_ticket_state.dart';
import 'package:kai_wisata/user/models/auth_cache.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
  ));

  await initDatabase();
  await AuthCache.instance.init();
  StationCaches.instance.init();
  WidgetsFlutterBinding.ensureInitialized();

  /*
  FlavorConfig(
    flavor: Flavor.prod,
    values: FlavorValues(
      baseUrl: 'http://139.162.28.12:3131',
      cachedLocale: int.parse(await getLocalization()),
    ),
  );
   */
  // ApiClient(values: FlavorConfig.instance.values);

  // debugPrint = (String message, {int wrapWidth}) {};
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegularTicketState()),
      ],
      child: const MyApp(),
    ),
  );
}
