import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/theme/app_colors.dart';

class BorderCustomContainer extends StatelessWidget {
  double height;
  double width;
  Widget child;
  EdgeInsetsGeometry? padding;
  BorderCustomContainer({
    required this.height,
    required this.width,
    required this.child,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(
          color: AppColors.primaryColor,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(15.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
            offset: Offset(2.w, 6.h), // Shadow position
          ),
        ],
        // gradient:
        //     LinearGradient(colors: [Colors.indigo, Colors.blueAccent]),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: child,
      ),
    );
  }
}
