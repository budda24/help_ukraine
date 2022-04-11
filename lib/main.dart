import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:pomoc_ukrainie/app/globals/global_controler.dart';


import 'app/modules/auth/views/choice_view.dart';
import 'app/routes/app_pages.dart';
import 'package:pomoc_ukrainie/helpers/theme/screen_sizes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(GlobalController());
  return  LayoutBuilder(
        builder: (context, constraints) => MediaQuery(
              data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window),
              child: ScreenUtilInit(
                designSize:
                    ScreenSizes(constraints: constraints).getScreenSize(),
                minTextAdapt: true,
                builder: () => GetMaterialApp(
                  title: "Application",
                  getPages: AppPages.routes,
                  /* initialRoute: Routes.AUTH, */
                home: AnimatedSplashScreen(
        splashIconSize: 300,
       duration: 4000,
        splash: 'assets/giphy.gif',
        nextScreen: const ChoiceScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color(0xff000000),

      ),
                  defaultTransition: Transition.fadeIn,
                  debugShowCheckedModeBanner: false,
                ),
              ),
            ));
  }
}


