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

