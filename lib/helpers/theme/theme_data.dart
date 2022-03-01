/* // Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../theme/text_styles.dart';
import 'app_colors.dart';
import 'button_styles.dart';

BoxDecoration dropdownButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(4),
  border: Border.all(color: AppColors.lightGreyColor, width: 2),
);

ThemeData themeStyle = ThemeData(
  textTheme: TextTheme(
    headline2: headlineTwoStyle,
    headline5: headlineFiveStyle,
    subtitle1: TextStyle(color: AppColors.whiteColor),
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: bodyStyle,
    unselectedLabelStyle: darkBodyStyle,
    labelColor: AppColors.whiteColor,
    unselectedLabelColor: AppColors.blackColor,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      color: AppColors.primaryColor,
    ),
  ),
  textButtonTheme: buttonStyle,
  // inputDecorationTheme: outlineInputTextFormFieldStyle,
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(AppColors.primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
  canvasColor: AppColors.primaryColor,
);
 */