// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'app_colors.dart';
import 'text_styles.dart';

InputDecoration? outlineInputTextFormFieldStyle = InputDecoration(
    /*  label: Text(
                          'Miasto',
                          style: textfieldLableStyle,
                        ), */
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(40.r),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(40.r),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(40.r),
    ),
    filled: true,
    fillColor: Colors.white70);
