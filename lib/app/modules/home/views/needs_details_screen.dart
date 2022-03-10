import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/rounded_container.dart';

import '../../../../helpers/theme/app_colors.dart';

class NeedsDetailsScreen extends StatelessWidget {
  const NeedsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BorderCustomContainer(
            height: 0.9.sh,
            width: 0.9.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/give_help.png')),
                verticalSpaceMedium,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Tytuł',
                    style: headingBlackStyle,
                  ),
                ]),
                verticalSpaceSmall,
                Text(
                  'adres : ',
                  style: headingBoldStyle,
                ),
                Divider(
                  color: AppColors.transparentBlackColor,
                  thickness: 2,
                ),
                Text(
                  'nr. tel. : ',
                  style: headingBoldStyle,
                ),
                Divider(
                  color: AppColors.transparentBlackColor,
                  thickness: 2,
                ),
                Text(
                  'email : ',
                  style: headingBoldStyle,
                ),
                Divider(
                  color: AppColors.transparentBlackColor,
                  thickness: 2,
                ),
                verticalSpaceMedium,
                RoundedContainer(
                  margin: EdgeInsets.zero,
                  borderCoplor: AppColors.primaryColor,
                  height: 0.4.sh,
                  width: 1.sw,
                  backgroundColor: AppColors.primaryColorShade,
                  child: ListView(children: [
                    Text('jaksdnjk asbdjjjjjjjjjj   jjjjjjjjjjjjjjj  jj jjjjjjjjjjjjjj j jjjjjjjjjjj jkkkkkkkkkkk k k  kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk kkkkk kk kkkkkkkkkkkkkkkkkk kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk   k k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk      kkkk kkkkkkkkkkkkkkkkkkkkkkkkkk kkkkkkkkkkkk kkkkkkkkkkkkkkk kkkkkkkkkkkkkkk kkkkkkkkkkkkkkkkkkkkkkk kkkkkkkkkkkkkkkk kkk k  kkkkkkkkkkkkkkk k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk kkkk kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk',style: headingBoldStyle,)
                  ],),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BorderCustomContainer extends StatelessWidget {
  double height;
  double width;
  Widget child;
  BorderCustomContainer({
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(
          color: AppColors.primaryColor,
          width: 3.0,
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
        child: child,
      ),
    );
  }
}
