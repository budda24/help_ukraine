import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomoc_ukrainie/app/modules/home/views/needs_details_screen.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/rounded_container.dart';

import '../../../../helpers/theme/app_colors.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            verticalSpaceExtraLarge,
            BorderCustomContainer(
              height: 100.h,
              width: 100.w,
              child: Image.asset(
                'assets/07-Lighthouse.png',
                fit: BoxFit.cover,
              ),
            ),
            verticalSpaceLarge,
            Text(
              'Profile name',
              style: headingBlackStyle,
            ),
            verticalSpaceLarge,
            Row(
              children: [
                Icon(
                  Icons.notification_add_outlined,
                  size: 40,
                ),
                horizontalSpaceSmall,
                Text(
                  'Tytuł potrzeby  ',
                  style: headingBoldStyle,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_circle_outline,
                    size: 40,
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.primaryColor,
              thickness: 2,
            ),
            verticalSpaceExtraLarge,
            RoundedContainer(
              borderCoplor: AppColors.primaryColor,
              height: 0.32.sh,
              width: 1.sw,
              backgroundColor: AppColors.primaryColorShade,
              child: Column(
                children: [
                  Text(
                    'Instrukcja instrukcja instrukcja po ukraińsku po ukrainsku  sakdkjasd sad,lkasmd sadas',
                    style: headingBoldStyle,
                  ),
                  verticalSpaceLarge,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {},
                      child: (Icon(
                        Icons.add_box_rounded,
                        size: 80,
                        color: AppColors.primaryColor,
                      )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
