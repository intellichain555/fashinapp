import 'package:flutter/material.dart';

class AppColor {
  static final kkPrimaryColor = Color(0xFFA8715A);
  static const kkSecondaryColor = Color(0xFFDD8560);
  static final kktTitleActiveColor = Color.fromRGBO(0, 0, 0, 1);

  static final kkBodyColor = Color.fromRGBO(51, 51, 51, 1);
  static final kkLabelColor = Color.fromRGBO(85, 85, 85, 1);
  static final kkPlaceHolderColor = Color.fromRGBO(136, 136, 136, 1);
  static final kkLineColor = Color.fromRGBO(221, 207, 187, 1);
  static final kkInputBackgroundColor = Color.fromRGBO(249, 249, 249, 1);
  static final kkBackgroundColor = Color.fromRGBO(248, 240, 231, 1);
  static final kkOffWhiteColor = Color.fromRGBO(252, 252, 252, 1);

  static final kkIconBackground = Color(0xFFC4C4C4).withOpacity(0.1);
}

final appBarThemeData = AppBarTheme().copyWith(
  backgroundColor: AppColor.kktTitleActiveColor,
);

//tags font is  tenor sans

final defaultHorizontalPadding = 12.0;
