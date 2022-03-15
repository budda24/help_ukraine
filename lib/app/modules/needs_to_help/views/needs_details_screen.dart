import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/modules/home/controllers/home_controller.dart';

import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/rounded_container.dart';
import '../../../../helpers/theme/app_colors.dart';
import '../../../infrastructure/fb_services/models/need.dart';
import '../controllers/needs_to_help_controller.dart';
import '../widgets/border_container.dart';

class NeedsDetailsScreen extends GetView<NeedsToHelpController> {
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
                GetBuilder<NeedsToHelpController>(
                  init: NeedsToHelpController(),
                  builder: (getBuilderController) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            getBuilderController.toogleLanguage(Language.pl);
                          },
                          child: Image.asset(
                            'assets/flags/poland-circular.png',
                            colorBlendMode: BlendMode.lighten,
                            color: getBuilderController.currantLanguage !=
                                    Language.pl
                                ? Colors.white30
                                : null,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/graphics/give_help.png',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            getBuilderController.toogleLanguage(Language.uk);
                          },
                          child: Image.asset(
                            'assets/flags/ukraine-circular.png',
                            colorBlendMode: BlendMode.lighten,
                            color: getBuilderController.currantLanguage !=
                                    Language.uk
                                ? Colors.white30
                                : null,
                          ),
                        ),
                      ]),
                ),
                verticalSpaceMedium,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [

                  GetBuilder<NeedsToHelpController>(
                    builder:(builController) =>Text(
                      builController.currantLanguage == Language.pl
                      ?need.title
                      :need.uaTitle,
                      style: parafraphBlackStyle,
                    ),
                  ),
                ]),
                verticalSpaceSmall,
                AutoSizeText(
                  '${need.address}',
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
                      GetBuilder<NeedsToHelpController>(
                        builder: (getBuilderController) {
                          return getBuilderController.currantLanguage ==
                                  Language.pl
                              ? Text(
                                  need.description,
                                  style: parafraphBlackStyle,
                                )
                              : Text(
                                  need.uaDescription,
                                  style: parafraphBlackStyle,
                                );
                        },
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
