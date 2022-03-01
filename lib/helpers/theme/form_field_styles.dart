// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'app_colors.dart';
import 'text_styles.dart';

InputDecorationTheme? outlineInputTextFormFieldStyle = InputDecorationTheme(
  labelStyle: outlineInputTextFormFieldLabelStyle,
  hintStyle: outlineInputTextFormFieldHintStyle,
  floatingLabelBehavior: FloatingLabelBehavior.always,
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: AppColors.greyColor), // Need To Change
    borderRadius: BorderRadius.circular(4),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.greyColor.withOpacity(0.8),
    ),
    borderRadius: BorderRadius.circular(4),
  ),
  disabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.greyColor.withOpacity(0.8),
    ),
    borderRadius: BorderRadius.circular(4),
  ),
  border: InputBorder.none,
  focusColor: AppColors.greyColor,
);
