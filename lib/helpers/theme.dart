import 'package:flutter/material.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: KaiColor.homeBackground,
  backgroundColor: KaiColor.homeBackground,
  fontFamily: 'Montserrat',
);

class KaiColor {
  static const homeBackground = Color(0xFFFFFFFF);
  static const white = Color(0xFFFFFFFF);
  static const blue = Color(0xFF0063A7);
  static const grey = Color(0xFFC4C4C4);
  static const black = Color(0xFF000000);
  static const fbBackground = Color(0xFF030081);
  static const googleBackground = Color(0xFF0078BC);
  static const green = Color(0xFF00C14D);
  static const darkRed = Color(0xFFFF0000);
  static const red = Color(0xFFEB5757);
  static const yellow = Color(0xFFFFA216);

  static const primary = Color(0xFF085DA1);
  static const neutral11 = Color(0xFFFAFAFA);
  static const greenText = Color(0xFF3BC425);
  static const greenBg = Color(0xFFE6F5E5);

  static const dark900 = Color(0xFF001A4D);
  static const neutral10 = Color(0xFFF5F5F5);
  static const neutral8 = Color(0xFFD9D9D9);
  static const neutral6 = Color(0xFF8C8C8C);
}

class KaiTextStyle {
  static const titleBigBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const titleSmallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const titleSmallThin = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const labelRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const smallRegular = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static const smallBold = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const smallThin = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  // Updated style

  static const bodyLargeBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const bodyLargeMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const bodyLargeRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const bodySmallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const bodySmallMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const bodySmallRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const captionLarge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const captionSmallMedium = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}
