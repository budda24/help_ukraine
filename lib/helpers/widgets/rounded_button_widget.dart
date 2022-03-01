/* import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/core/app_texts.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isActive;
  final Function action;
  const RoundedButtonWidget(
      {required this.buttonText,
      required this.isActive,
      required this.action,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await action();
        },
        child: Container(
          decoration: BoxDecoration(
              color: isActive ? AppColors.buttonColor : AppColors.accentColor,
              borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: RoundedButtonLabel(buttonText),
        ));
  }
}
 */