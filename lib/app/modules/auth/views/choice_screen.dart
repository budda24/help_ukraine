import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pomoc_ukrainie/app/modules/auth/controllers/auth_controller.dart';
import 'package:pomoc_ukrainie/app/modules/home/views/user_profile.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import '../../../infrastructure/fb_services/auth/auth.dart';
import '../../../routes/app_pages.dart';

class ChoiceScreen extends GetView<AuthController> {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  verticalSpaceExtraLarge,
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.NEEDS_TO_HELP);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 300.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 3.0.w,
                        ),
                        borderRadius: BorderRadius.circular(15.0.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 4,
                            offset: Offset(2.w, 6.h), // Shadow position
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: GridTile(
                          child: Image.asset(
                            'assets/graphics/support.png',
                            // fit: BoxFit.cover,

                            cacheHeight: 200.h.toInt(),
                            cacheWidth: 200.h.toInt(),
                          ),
                          header: Text(
                            'Я хочу допомогти',
                            textAlign: TextAlign.center,
                            style: headingBlackStyle,
                          ),
                          footer: Text(
                            'Chcę pomóc ',
                            textAlign: TextAlign.center,
                            style: headingBlackStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceExtraLarge,
                  InkWell(
                    onTap: () {
                      if (auth.currentUser != null) {
                        user = auth.currentUser;
                        Get.to(UserProfile());
                      } else
                        Get.toNamed(Routes.AUTH);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 300.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 3.0.w,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 4,
                            offset: Offset(2, 6), // Shadow position
                          ),
                        ],
                        // gradient:
                        //     LinearGradient(colors: [Colors.indigo, Colors.blueAccent]),
                      ),
                      child: ClipRRect(
                        child: GridTile(
                          child: Image.asset(
                            'assets/graphics/help.png',
                            cacheHeight: 200.h.toInt(),
                            cacheWidth: 200.h.toInt(),
                          ),
                          header: Text(
                            'Шукаю допомоги',
                            textAlign: TextAlign.center,
                            style: headingBlackStyle,
                          ),
                          footer: Text(
                            'Szukam pomocy',
                            textAlign: TextAlign.center,
                            style: headingBlackStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
