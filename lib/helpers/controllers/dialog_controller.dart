/* // Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// Project imports:
import '/app/theme/alert_styles.dart';
import '/app/theme/button_styles.dart';
import '/app/theme/ui_helpers.dart';
import '/app/widgets/core/dialog_label.dart';
import '/app/widgets/loading_indicators.dart';
import '/domain/utils/extensions.dart';

class DialogController extends GetxController {
  File? image = File('/app/lib/assets/images/Integrate+_full.png');
  RxBool isLoading = false.obs;

  String? selectedFileFormat = 'CSV';
  final List<String> exportFileFormats = ['CSV', 'XLS'];

  void showSuccessFailureDialog({
    required BuildContext context,
    required bool isSuccess,
    required String text,
  }) {
    Alert(
      context: context,
      style: centeredAlertStyle,
      content: SizedBox(
        width: 353.w,
        height: 334.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(
                  flex: 3,
                ),
                DialogTitleLabel(
                  isSuccess ? 'Success' : 'Failed',
                ),
                const Spacer(flex: 2),
                IconButton(
                  onPressed: Get.back,
                  icon: Image.asset(
                    'assets/images/icons/cross_icon2.png',
                    height: 24.sp,
                  ),
                )
              ],
            ),
            verticalSpaceMediumTwo,
            Container(
              height: 72.sp,
              width: 72.sp,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/icons/${isSuccess ? 'check_icon' : 'cross_icon'}.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            verticalSpaceMedium,
            DialogMessageLabel(
              isSuccess ? text : 'Something went wrong',
            ),
            verticalSpaceMediumTwo,
            TextButton(
              onPressed: () {
                Get.back();
              },
              style: whiteButtonStyle.style,
              child: DialogButtonLabel('Close'),
            )
          ],
        ),
      ),
    ).show();
  }

  Future<void> showDialog({
    required BuildContext context,
    required String title,
    required String message,
    required dynamic action,
    required String submitButtonText,
    required bool isShowCancelButton,
  }) async {
    Alert(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().uiSize.isMobile ? 10 : 12,
      ),
      context: context,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DialogTitleLabel(
                title,
              ),
              const Spacer(),
              IconButton(
                onPressed: Get.back,
                icon: Image.asset(
                  'assets/images/icons/cross_icon2.png',
                  height: 24.sp,
                ),
              )
            ],
          ),
          verticalSpaceMedium,
          DialogMessageLabel(
            message,
          ),
          verticalSpaceLarge,
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  await action();
                },
                style: whiteButtonStyle.style,
                child: Obx(
                  () => isLoading.value
                      ? defaultLoadingIndicator
                      : DialogButtonLabel(
                          submitButtonText,
                        ),
                ),
              ),
              if (ScreenUtil().uiSize.isMobile)
                horizontalSpaceTiny
              else
                horizontalSpaceSmall,
              TextButton(
                onPressed: () => Get.back(),
                style: buttonStyle.style,
                child: Obx(
                  () => isLoading.value
                      ? defaultLoadingIndicator
                      : DialogButtonWhiteLabel(
                          'Cancel',
                        ),
                ),
              )
            ],
          ),
        ],
      ),
      style: defaultAlertStyle,
    ).show();
  }
}
 */