import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/auth/auth.dart';
import 'package:pomoc_ukrainie/app/modules/auth/controllers/auth_controller.dart';
import 'package:pomoc_ukrainie/app/routes/app_pages.dart';

import '../../../../helpers/theme/app_bars.dart';
import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/text_styles.dart';
import '../../../../helpers/widgets/online_tribes/main_button.dart';

class RestPasswordView extends GetView<AuthController> {
  @override
  /* final controller = Get.put(ResetPasswordController());*/
  final globalController = Get.put(GlobalController());

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        appBar: AppBarBackArrow(
          title: Text(
            'Forgot password',
            style: headingBoldStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 0.3.sh),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller.resetPassEmailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(fontSize: 16.sp),
                      contentPadding: EdgeInsets.all(16.r),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.28.sh,
              ),
              SlimRoundedButton(
                title: 'Subbmit',
                textColor: AppColors.whiteColor,
                onPress: () {
                  Auth().resetPasswordEmail(controller.resetPassEmailController.text);
                },
                backgroundColour: AppColors.primaryColor,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Don't have an account",
                  style: smallTextStyle,
                ),
                TextButton(
                  onPressed: () async {
                    controller.authMode = AuthMode.Signup;
                    Get.offAndToNamed(Routes.AUTH);
                  },
                  child: Text('SIGN UP'),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
