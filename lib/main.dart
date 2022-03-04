import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/helpers/theme/screen_sizes.dart';

import 'app/modules/home/views/choice_screen.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) => MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window),
            child: ScreenUtilInit(
              designSize: ScreenSizes(constraints: constraints).getScreenSize(),
              minTextAdapt: true,
              builder: () => GetMaterialApp(
                /*  theme: themeStyle, */
                title: "Application",
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
                home: ChoiceScreen(),
                defaultTransition: Transition.fadeIn,
                debugShowCheckedModeBanner: false,
              ),
            ),
          ));
}

// Flutter imports:
