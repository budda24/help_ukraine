// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
/* import 'package:flutter_alert/flutter_alert.dart'; */

// Project imports:
import '../theme/text_styles.dart';
import 'app_colors.dart';


GetSnackBar customSnackbar ({required String message, required IconData icon, required String title}){return GetSnackBar(
  icon:Icon(icon, color: AppColors.errorRedColor, size: 35,),
    duration: 4.seconds,
    snackPosition: SnackPosition.TOP,
    titleText: Text(
      title,
      style: headingBlackStyle,
    ),
    messageText: Text(
      message,
      style: montserratBold,
    ),
    backgroundColor: AppColors.primaryColorWithOpacity40,
  );}

