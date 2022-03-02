import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/modules/home/views/choice_screen.dart';
import 'package:pomoc_ukrainie/helpers/main_constants.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_bars.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/login_services_Icon.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/main_button.dart';

import '../controllers/auth_controller.dart';


class AuthView extends GetView<AuthController> {
  var globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 809),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              verticalSpaceExtraLarge,

              /* GreenWaves1(screeanheight: 735.h), */
              Container(
                height: 380.h,
                width: double.infinity,
                /*padding: EdgeInsets.all(screeanheight*01),
                    margin: EdgeInsets.only(top: screeanheight * 0.025),*/
                child: Center(
                  child: Image.asset(
                    'assets/helping-01.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              verticalSpaceMedium,
              Text(
                'Увійти за допомогою',
                style: headingBlackStyle,
                textAlign: TextAlign.center,
              ),
              verticalSpaceTiny,
              Text(
                'Zaloguj się przez',
                style: headingBlackStyle,
                textAlign: TextAlign.center,
              ),
              LoginServicesIcons(
                onTapFaccebook: () {},
                onTapGoogle: () {
                  Get.to(ChoiceScreen());
                },
              ),
            ],
          ),
        ),
      ),
    ) /* ,
    ) */
        ;
  }
}
