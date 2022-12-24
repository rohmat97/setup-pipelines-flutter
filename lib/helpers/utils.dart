import 'package:flutter/material.dart';

double statusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
