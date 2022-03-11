import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/auth/auth.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';
import 'package:pomoc_ukrainie/app/modules/home/controllers/home_controller.dart';
import 'package:pomoc_ukrainie/app/modules/home/views/needs_details_screen.dart';
import 'package:pomoc_ukrainie/app/modules/home/widgets/need_tile.dart';
import 'package:pomoc_ukrainie/app/modules/models/need.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/rounded_container.dart';

import '../../../../helpers/theme/app_colors.dart';
import 'add_need_view.dart';

class UserProfile extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    print('start build');
    /* controller.getNeedsUser(); */
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
              child: Image.network(
                user!.photoURL ??
                    'https://dsm01pap004files.storage.live.com/y4m_WyBC3VOwYN6wDoyWTw8ZaonCA_3fhOfEn3DQbrinoLzMG9gAxftCacktBSEbc04zRdbqhmFanYO0qrEOTLla6_CZe5tYMI4-3x9tp1xd5zsCvzPYnoeDQ3AS5VtZqTRGlRtm56YScvVl0kexFgiKupCTtx2a1mpvBagBTIi6kI29Hl3KqZGxAboOmSGn_QF?width=128&height=128&cropmode=none',
                fit: BoxFit.cover,
              ),
            ),
            verticalSpaceLarge,
            Text(
              user!.displayName ?? 'NO USER NAME',
              style: headingBlackStyle,
            ),
            verticalSpaceLarge,
            Divider(
              color: AppColors.primaryColor,
              thickness: 2,
            ),
            Container(
              height: 0.15.sh,
              width: 0.8.sw,
              child: GetBuilder<HomeController>(
                init: HomeController(),
                builder: (controller) => ListView.builder(
                  itemCount: controller.needs.length,
                  itemBuilder: (_, index) {
                    return NeedTile(
                        need: controller.needs[index],
                        deleteNeed: controller.deleteNeed);
                  },
                ),
              ),
            ),
            RoundedContainer(
              margin: EdgeInsets.only(top: 60),
              borderCoplor: AppColors.primaryColor,
              height: 0.30.sh,
              width: 1.sw,
              backgroundColor: AppColors.primaryColorShade,
              child: Column(
                children: [
                  Text(
                    'Щоб отримати допомогу, натисніть кнопку нижче та заповніть форму заявки. Якщо заявка заповнена або застаріла - видаліть програму зі свого профілю.',
                    style: headingBoldStyle,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () async {
                        Get.to(AddNeedView());
                      },
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
