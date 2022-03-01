import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,

      body: Center(
        child: Column(
          children: [
            verticalSpaceExtraLarge,
            Container(
              height: 300.h,
              width: 300.w,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(
                  color: Colors.black54,
                  width: 1.0.w,
                ),
                borderRadius: BorderRadius.circular(15.0.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 4,
                    offset: Offset(2.w, 6.h), // Shadow position
                  ),
                ],
                // gradient:
                //     LinearGradient(colors: [Colors.indigo, Colors.blueAccent]),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GridTile(

                  child: Image.asset(

                    'assets/heart.png',
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
           verticalSpaceExtraLarge,
            Container(
              height: 300.h,
              width: 300.w,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(
                  color: Colors.black54,
                  width: 1.0.w,
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
                borderRadius: BorderRadius.circular(15),
                child: GridTile(

                  child: Image.asset(
                    'assets/hand.png',

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


          ],
        ),
      ),
    );
  }
}
