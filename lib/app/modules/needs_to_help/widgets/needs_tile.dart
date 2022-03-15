import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/text_styles.dart';
import '../../../infrastructure/fb_services/models/need.dart';
import '../views/needs_details_screen.dart';

class NeedsTile extends StatelessWidget {
  Need need;
  NeedsTile({required this.need});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(15.0.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        onTap: () {
          Get.to(NeedsDetailsScreen(need: need,));
        },
        selectedTileColor: Colors.grey[300],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        leading: Icon(
          Icons.add_alert_sharp,
          size: 26,
        ),
        title: Text(
          need.title,
          style: headingBlackStyle,
        ),
      ),
    );
  }
}
