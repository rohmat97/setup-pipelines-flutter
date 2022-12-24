import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const prefTokenBox = 'pref_token_box';
const prefLocalBox = 'pref_local_box';

Box? tokenBox;
Box? localBox;
Future<void> initDatabase() async {
  await Hive.initFlutter();
  tokenBox = await Hive.openBox<void>(prefTokenBox);
  localBox = await Hive.openBox<void>(prefLocalBox);
}

const prefTokenUser = 'pref_user_token';
Future<String> getToken() async {
  final String userToken = await tokenBox!.get(prefTokenUser, defaultValue: '');
  return userToken;
}

Future<void> saveToken(String token) async {
  if (tokenBox != null) {
    await tokenBox!.put(prefTokenUser, token);
  }
}

Future<void> removeToken() async {
  if (tokenBox != null) {
    await tokenBox!.delete(prefTokenUser);
  }
}

const prefLocalization = 'pref_localization';
Future<String> getLocalization() async {
  final String localization =
      await localBox!.get(prefLocalization, defaultValue: '1');
  return localization;
}

Future<void> saveLocalization(String localization) async {
  if (localBox != null) {
    await localBox!.put(prefLocalization, localization);
  }
}

Future<void> removeLocalization() async {
  if (localBox != null) {
    await localBox!.delete(prefLocalization);
  }
}
