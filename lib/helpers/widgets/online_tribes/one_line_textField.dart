import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';

import '../../theme/app_colors.dart';

class OneLineTextField extends StatelessWidget {
  final String lable;
  final TextEditingController controller;
  final bool isOscure;
  final Function validator;
  TextInputType? keybordhType;
  OneLineTextField({
    Key? key,
    required this.lable,
    required this.controller,
    required this.validator,
    this.keybordhType,
    this.isOscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      height: 70.h,
      width: 320.w,
      child: TextFormField(
        keyboardType:keybordhType?? TextInputType.text,
        validator: (text) => validator(text),
        obscureText: isOscure,
        controller: controller,
        decoration: InputDecoration(
            label: Text(
              lable,
              style: textfieldLableStyle,
            ),
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
            fillColor: Colors.white70),
      ),
    );
  }
}
