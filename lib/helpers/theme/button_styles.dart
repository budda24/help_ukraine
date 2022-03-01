/* // Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../theme/text_styles.dart';
import 'app_colors.dart';

TextButtonThemeData buttonStyle = TextButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    ),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(160, 45),
    ),
    backgroundColor: MaterialStateProperty.all<Color?>(AppColors.primaryColor),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(color: AppColors.primaryColor!),
      ),
    ),
  ),
);

TextButtonThemeData popupButtonStyle = TextButtonThemeData(
  style: ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(double.infinity, 45),
    ),
    backgroundColor: MaterialStateProperty.all<Color?>(AppColors.primaryColor),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
        side: BorderSide(color: AppColors.primaryColor!),
      ),
    ),
  ),
);

TextButtonThemeData whiteButtonStyle = TextButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      popUpMessageStyle,
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    ),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(180, 45),
    ),
    backgroundColor: MaterialStateProperty.all<Color?>(AppColors.whiteColor),
    foregroundColor: MaterialStateProperty.all<Color?>(AppColors.blackColor),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(color: AppColors.lightGreyColor),
      ),
    ),
  ),
);

TextButtonThemeData whiteButtonStyleTwo = TextButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    ),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(73, 25),
    ),
    backgroundColor: MaterialStateProperty.all<Color?>(AppColors.whiteColor),
    foregroundColor: MaterialStateProperty.all<Color?>(AppColors.primaryColor),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(color: AppColors.lightGreyColor),
      ),
    ),
  ),
);

TextButtonThemeData transparentButtonStyle = TextButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    ),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(180, 45),
    ),
    backgroundColor: MaterialStateProperty.all<Color?>(AppColors.whiteColor),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: BorderSide(color: AppColors.whiteColor!),
      ),
    ),
  ),
);

TextButtonThemeData dialogButtonStyle = TextButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 19, vertical: 19),
    ),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(180, 45),
    ),
    backgroundColor: MaterialStateProperty.all<Color?>(AppColors.primaryColor),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  ),
);
 */