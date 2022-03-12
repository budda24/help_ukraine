import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/rounded_container.dart';
import '../../../../helpers/theme/app_colors.dart';
import '../../models/need.dart';
import '../widgets/border_container.dart';

class NeedsDetailsScreen extends StatelessWidget {
  Need need;
  NeedsDetailsScreen({required this.need});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BorderCustomContainer(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                    need.title,
                    style: parafraphBlackStyle,
                  ),
                ]),
                verticalSpaceSmall,
                AutoSizeText(
                  ' ${need.address}',
                  maxLines: 3,
                  style: parafraphBlackStyle,
                ),
                Divider(
                  color: AppColors.transparentBlackColor,
                  thickness: 2,
                ),
                AutoSizeText(
                  '${need.contact}',
                  maxLines: 1,
                  style: parafraphBlackStyle,
                ),
                Divider(
                  color: AppColors.transparentBlackColor,
                  thickness: 2,
                ),
                AutoSizeText(
                  '${need.email}',
                  maxLines: 1,
                  style: parafraphBlackStyle,
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
                  child: ListView(
                    children: [
                      Text(
                        need.description,
                        style: parafraphBlackStyle,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
