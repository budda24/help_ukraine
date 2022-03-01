// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

double mobileSize = 480;
double tabletSize = 767;
double largeTablet = 965;
double desktopSize = 1240;
double mediumDesktopSize = 1780;
double largeDesktopSize = 1780;

Widget horizontalSpaceExtraTiny = SizedBox(width: 5.w);
Widget horizontalSpaceTiny = SizedBox(width: 10.w);
Widget horizontalSpaceSmall = SizedBox(width: 15.w);
Widget horizontalSpaceMedium = SizedBox(width: 25.w);
Widget horizontalSpaceLarge = SizedBox(width: 50.w);
Widget horizontalSpaceMassive = SizedBox(width: 70.w);

Widget verticalSpaceTiny = SizedBox(height: 10.0.h);
Widget verticalSpaceSmall = SizedBox(height: 20.0.h);
Widget verticalSpaceMedium = SizedBox(height: 25.0.h);
Widget verticalSpaceMediumTwo = SizedBox(height: 40.0.h);
Widget verticalSpaceMediumThree = SizedBox(height: 35.0.h);
Widget verticalSpaceLarge = SizedBox(height: 50.0.h);
Widget verticalSpaceExtraLarge = SizedBox(height: 65.0.h);
Widget verticalSpaceMassive = SizedBox(height: 120.0.h);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

bool isDesktop(BuildContext context) => screenWidth(context) > tabletSize;
bool isMobile(BuildContext context) => screenWidth(context) <= mobileSize;

double screenHeightFraction(
  BuildContext context, {
  double dividedBy = 1,
  double offsetBy = 0,
}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(
  BuildContext context, {
  double dividedBy = 1,
  double offsetBy = 0,
}) =>
    (screenWidth(context) - offsetBy) / dividedBy;
