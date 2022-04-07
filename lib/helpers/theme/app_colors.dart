// Flutter imports:
import 'package:flutter/material.dart';

Color? getColorFromHex(String? hexColor, Color? defaultColor) {
  String? currentHexColor =
      hexColor == null ? '' : hexColor.replaceAll('#', '');
  if (currentHexColor.length == 6) {
    currentHexColor = 'FF$currentHexColor';
    return Color(int.parse('0x$currentHexColor'));
  }
  if (currentHexColor.length == 8) {
    return Color(int.parse('0x$currentHexColor'));
  }
  return defaultColor;
}

class AppColors {
  AppColors();

  // Global Colors

  static Color primaryColor = const Color(0xff85F4FF);
  static Color primaryColorShade = Color(0xffEFFFFD);
  /* static Color primaryColorShade = Color.fromARGB(255, 243, 223, 177); */
  static Color textFieldFill = const Color(0xffCBFAE2);
  static Color primaryColorWithOpacity40 = const Color(0xffD2FEE4);
  static Color googleColor = const Color(0xffDF4A32);
  static Color facebookColor = const Color(0xff39579A);
  static Color whiteColor = Colors.white;
  static Color blueColor = Color(0xff82ACEA);
  static Color blackColor = Colors.black;
  static Color greyColor = Color(0xff707070);
  static Color darkGreyColor = Color(0xff808080);
  static Color darkOrangeColor = Color(0xffE5A238);
  static Color errorRedColor = Color(0xffCD5D7D);
  static Color transparentBlackColor = Colors.black54;

  
}
