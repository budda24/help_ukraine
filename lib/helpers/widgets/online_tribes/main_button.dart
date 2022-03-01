
// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:



class SlimRoundedButton extends StatelessWidget {
  Color backgroundColour;
  Color textColor;
  String title;
  VoidCallback onPress;
  /* double screenWidth;
  double screenHeight; */

  SlimRoundedButton(
      {required this.backgroundColour,
        required this.title,
        required this.textColor,
        required this.onPress,
        /* required this.screenWidth,
        required this.screenHeight */});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
            left: 120.w,
            right: 120.w,
            top: 12.h,
            bottom: 12.h)),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColour),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0.r)),
        ),
      ),
      child: Text(
        title,
        style:
        TextStyle(fontFamily: 'Montserrat', fontSize: 24, color: textColor),
      ),
      onPressed: onPress,
    );
  }
}