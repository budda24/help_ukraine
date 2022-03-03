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

  /*  static Color? accentColor = const Color(0xFF312951);
  static Color? buttonColor = const Color(0xFF592AAE);
  static Color? bodyColorTwo = const Color(0xFFCABCFF);
  static Color lightGreyColor = const Color(0xFFE9EEF2);
  static Color? navyTextColor = const Color(0xFF001D3B);
  static Color? lightNavyTextColor = const Color(0xFF34587E);
  static Color? greyTwoColor = const Color(0xFF7592A8);
  static Color? darkGreyColor = const Color(0xFFE9EEF2);
  static Color? circularProgressIndicatorColor = const Color(0xFF2C2C2C);
  static Color? circularProgressIndicatorInButtonColor =
      const Color(0xFF2C2C2C);

  static Color? lightBlackColor = const Color(0xff1E1E1E);


  static Color? redColor = const Color(0xFFFF5964);
  static Color? lightRedColor = const Color(0xFFFFDEE0);
  static Color? redTextColor = const Color(0xFF60040A);

  static Color? yellowColor = const Color(0xFFFFC000);
  static Color? lightYellowColor = const Color(0xFFFFF2CC);
  static Color? yellowTextColor = const Color(0xFF745C12);

  static Color? greenColor = const Color(0xFF00D4AA);
  static Color? lightGreenColor = const Color(0xFFCCF6EE);
  static Color? darkGreenColor = const Color(0xFF01604D);

  /* static Color? blueColor = const Color(0xFF00CDF8); */
  static Color? lightBlueColor = const Color(0xFFCCF5FE);

  static String redHexColor = '#E11C1C';
  static String blueHexColor = '#40C2F3';
  static String greenHexColor = '#22C316';*/
}
