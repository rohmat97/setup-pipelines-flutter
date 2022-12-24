
import 'package:flutter/material.dart';

import '../commons.dart';

class MyTextStyle {
  MyTextStyle._();

  static TextStyle heading1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600
  );

  static TextStyle heading2 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600
  );

  static TextStyle money = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.blue
  );

  static TextStyle info = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Colors.grey
  );


  static TextStyle success = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Colors.green
  );

  static TextStyle warning = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: MyColors.danger
  );
}
