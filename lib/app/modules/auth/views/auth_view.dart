import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/auth/auth.dart';

import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/login_services_Icon.dart';

import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/text_styles.dart';
import '../controllers/auth_controller.dart';
import 'choice_view.dart';
import 'reset_password_view.dart';

class AuthView extends GetView<AuthController> {
  var globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        globalController.isLoading = false;
        return await Get.offAll(const ChoiceScreen());
      },
      child: GestureDetector(
        onTap: () => globalController.unFocuseNode(),
        child: Scaffold(
          body: GetBuilder<GlobalController>(
            builder: (globalController) => Center(
              child: globalController.isLoading
                  ? const LinearProgressIndicator()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
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
                            'Увійти за допомогою', //Login with
                            style: headingBlackStyle,
                            textAlign: TextAlign.center,
                          ),
                          verticalSpaceTiny,
                          Form(
                            key: controller.formKey,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: GetBuilder<AuthController>(
                                builder: (controller) => Column(
                                  children: <Widget>[
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Електронна пошта'), //Email
                                      keyboardType: TextInputType.emailAddress,
                                      controller: controller.emailController,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Пароль'), //password
                                      obscureText: true,
                                      controller: controller.passwordController,
                                    ),
                                    if (controller.authMode == AuthMode.Signup)
                                      TextFormField(
                                        controller: controller
                                            .confirmPasswordController,
                                        enabled: controller.authMode ==
                                            AuthMode.Signup,
                                        decoration: const InputDecoration(
                                            labelText:
                                                'Підтвердьте пароль'), //confirm password
                                        obscureText: true,
                                      ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColors.primaryColor),
                                              textStyle:
                                                  MaterialStateProperty.all(
                                                      headingWhiteStyle),
                                            ),
                                            child: Text(controller.authMode ==
                                                    AuthMode.Login
                                                ? 'УВІЙТИ' //login
                                                : 'ЗАПИСАТИСЯ'), //signin
                                            onPressed: () async =>
                                                controller.authMode ==
                                                        AuthMode.Login
                                                    ? await controller.signIn()
                                                    : await controller.signUp(),
                                          ),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Get.to(RestPasswordView());
                                              },
                                              child: Text(
                                                'Забули пароль', //forgot password
                                                style: smallTextStyle,
                                              ))
                                        ]),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.primaryColor),
                                        textStyle: MaterialStateProperty.all(
                                            headingWhiteStyle),
                                      ),
                                      child: Text(
                                        controller.authMode == AuthMode.Login
                                            ? 'Я НЕ МАЮ ОБЛІКУ' /* I DON\'T HAVE ACCOUNT  */ : 'Я ВЖЕ МАЮ РАХУНК',
                                        style: headingWhiteStyle,
                                      ),
                                      onPressed: controller.switchAuthMode,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          LoginServicesIcons(
                            onTapGoogle: () async {
                              await Auth().signInWithGoogle();
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
