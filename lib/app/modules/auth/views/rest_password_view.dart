import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/routes/app_pages.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_bars.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/main_button.dart';

class RestPasswordView extends GetView {
  var globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RestPasswordView'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: globalController.unFocuseNode,
        child: Scaffold(
          appBar: AppBarBackArrow(
            title: Text(
              'Forgot password',
              style: headingBoldStyle,
            ),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 0.3.sh),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: controller.emailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter a product name eg. pension',
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
                      controller.reset();
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
                        //go to registration
                      },
                      child: Text('SIGN UP'),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
