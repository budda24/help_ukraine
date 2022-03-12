import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/auth/auth.dart';

import 'package:pomoc_ukrainie/app/modules/home/views/user_profile.dart';
import 'package:pomoc_ukrainie/helpers/main_constants.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_bars.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/login_services_Icon.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/main_button.dart';

import '../controllers/auth_controller.dart';
import 'choice_screen.dart';

class AuthView extends GetView<AuthController> {
  var globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        body: GetBuilder<GlobalController>(
          builder: (controller) => Center(
            child: globalController.isLoading
                ? LinearProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 380.h,
                        width: double.infinity,
                        child: Center(
                          child: Image.asset(
                            'assets/graphics/07-Lighthouse.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Увійти за допомогою',
                        style: headingBlackStyle,
                        textAlign: TextAlign.center,
                      ),
                      verticalSpaceTiny,
                      LoginServicesIcons(
                        onTapFaccebook: () async {
                          await Auth().signInWithFacebook();
                        },
                        onTapGoogle: () async {
                          await Auth().signInWithGoogle();
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
