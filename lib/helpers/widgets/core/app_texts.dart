// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/font_sizes.dart';

// Project imports:
import '../../theme/app_colors.dart';
import '../../theme/fonts.dart';
import '../../theme/text_styles.dart';

/* class CardSubheadingLabel extends Text {
  CardSubheadingLabel(String data)
      : super(
          data.toUpperCase(),
          style: TextStyle(
              fontSize: smallTextSize,
              fontFamily: monropeMedium,
              color: AppColors.bodyColorTwo),
        );
}

class CardHeadingLabel extends Text {
  CardHeadingLabel(String data)
      : super(
          data,
          style: TextStyle(
              fontSize: headingThreeSize,
              fontFamily: monropeBold,
              color: AppColors.whiteColor),
        );
}

class CardBodyLabel extends Text {
  CardBodyLabel(String data)
      : super(
          data,
          maxLines: 3,
          style: TextStyle(
              fontSize: regularTextSize,
              overflow: TextOverflow.ellipsis,
              fontFamily: monropeRegular,
              color: AppColors.bodyColorTwo),
        );
}

class RoundedButtonLabel extends Text {
  RoundedButtonLabel(String data)
      : super(
          data,
          style: TextStyle(
              color: AppColors.whiteColor,
              fontFamily: monropeRegular,
              fontSize: headingThreeSize),
        );
} */

class HeadingTextLabel extends Text {
  HeadingTextLabel(String data)
      : super(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: headingOneSize,
              fontFamily: poppinsBold),
        );
}

/* class ButtonLabel extends Text {
  ButtonLabel(String data)
      : super(
          data,
          style: TextStyle(
            fontFamily: monropeRegular,
            fontSize: 14.sp,
            color: AppColors.whiteColor,
            fontFeatures: const [FontFeature.proportionalFigures()],
          ),
        );
}

class NoDataDescription extends Text {
  NoDataDescription(String data)
      : super(
          data,
          style: bodyStyle.copyWith(
            fontSize: 14,
            height: 1.5,
            color: AppColors.greyTwoColor,
            fontFeatures: const [FontFeature.proportionalFigures()],
          ),
          textAlign: TextAlign.center,
        );
}

class NoDataTitleLabel extends Text {
  NoDataTitleLabel(String data)
      : super(
          data,
          style: headlineFourStyle.copyWith(
            height: 1.5,
            color: AppColors.primaryColor,
            fontFeatures: const [FontFeature.proportionalFigures()],
          ),
          textAlign: TextAlign.center,
        );
}

class PopUpMenuItemLabel extends Text {
  PopUpMenuItemLabel(String data)
      : super(
          data,
          style: headlineFiveStyle.copyWith(
            fontSize: 14.sp,
            fontFeatures: const [FontFeature.proportionalFigures()],
          ),
        );
}
 */