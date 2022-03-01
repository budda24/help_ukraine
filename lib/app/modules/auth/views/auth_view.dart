import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/helpers/main_constants.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_bars.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/login_services_Icon.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/main_button.dart';

import '../controllers/auth_controller.dart';
import 'rest_password_view.dart';

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
          appBar: AppBar(
            backgroundColor: Color(0xffF5BD3F),
            title: Text('Pomóżmy'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    /* GreenWaves1(screeanheight: 735.h), */
                    Center(
                      child: Container(
                        height: 350.h,
                        width: double.infinity,
                        /*padding: EdgeInsets.all(screeanheight*01),
                    margin: EdgeInsets.only(top: screeanheight * 0.025),*/
                        child: Center(
                          child: Image.asset('assets/helping-01.png',fit: BoxFit.fill,),),
                    ),
                      ),
                  ]  ),
                  verticalSpaceMedium,
                Form(
                  /* key: controller.formKey, */
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 41.w),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.emailController,
                              maxLength: 320,
                              autofillHints: [AutofillHints.email],
                              keyboardType: TextInputType.emailAddress,
                              enableSuggestions: true,
                              style: outlineInputTextFormFieldHintStyle,
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
                            ),
                            horizontalSpaceTiny,
                            TextFormField(
                              controller: controller.passwordController,
                              maxLength: 120,
                              keyboardType: TextInputType.text,
                              obscuringCharacter: '*',
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              style: outlineInputTextFormFieldHintStyle,
                              decoration: InputDecoration(
                                hintText: 'Hasło',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 30.w),
                              child: TextButton(
                                child: Text('Zapomniałem Hasła?',
                                    style: kTextCheckBox),
                                onPressed: () {
                                  Get.to(RestPasswordView());
                                },
                              ))
                        ],
                      ),
                      Center(
                        child: SlimRoundedButton(
                          onPress: (){
                            //perform sign in
                          },
                          title: 'Zaloguj',
                          backgroundColour: AppColors.primaryColor,
                          textColor: kColorWhite,
                        ),
                      ),
                      LoginServicesIcons(
                        onTapFaccebook: () {},
                        onTapGoogle: () {},
                      ),
                      TextButton(
                        onPressed: () async {
                          //go to registration
                        },
                        child: Text('Zarejstruj', style: headingBlackStyle,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    )/* ,
    ) */;
  }
}
