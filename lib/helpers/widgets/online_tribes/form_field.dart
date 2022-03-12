import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main_constants.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.maxline,
    required this.minLine,
    required this.height,
    required this.width,
    required this.validate,
    this.hintText,
    this.controller,
    this.color,
    this.lableText,
    this.maxLenght,
    this.focusNode,
    this.onSubmit
  }) : super(key: key);

  final int minLine;
  final int maxline;
  final double height;
  final double width;
  String? hintText;
  String? lableText;
  TextEditingController? controller;
  Color? color;
  final Function validate;
  int? maxLenght;
  FocusNode? focusNode;
  void onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved:(_) => onSubmit,
      focusNode: focusNode,
      maxLength: maxLenght,
      textInputAction: TextInputAction.next,
      validator: (text) => validate(text),
      controller: controller,
      style: kTextfieldStyle,
      keyboardType: TextInputType.multiline,
      minLines: minLine,
      maxLines: maxline,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
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
        labelText: lableText ?? '',
        hintStyle: kTextfieldStyle,
        filled: true,
        fillColor: AppColors.primaryColorShade,
        hintText: hintText, /* contentPadding: EdgeInsets.all(15) */
      ),
    );
  }
}
