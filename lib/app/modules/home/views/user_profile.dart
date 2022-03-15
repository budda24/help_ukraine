import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/auth/auth.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';
import 'package:pomoc_ukrainie/app/modules/home/controllers/home_controller.dart';
import 'package:pomoc_ukrainie/app/modules/home/widgets/need_tile.dart';
import 'package:pomoc_ukrainie/app/routes/app_pages.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/rounded_container.dart';

import '../../../../helpers/theme/app_colors.dart';
import '../../../infrastructure/fb_services/models/need.dart';
import '../../needs_to_help/widgets/border_container.dart';
import 'add_need_view.dart';

class UserProfile extends GetView<HomeController> {
  var controller = Get.put(HomeController());
  String placeHolderPhoto =
      'https://dsm01pap004files.storage.live.com/y4m_WyBC3VOwYN6wDoyWTw8ZaonCA_3fhOfEn3DQbrinoLzMG9gAxftCacktBSEbc04zRdbqhmFanYO0qrEOTLla6_CZe5tYMI4-3x9tp1xd5zsCvzPYnoeDQ3AS5VtZqTRGlRtm56YScvVl0kexFgiKupCTtx2a1mpvBagBTIi6kI29Hl3KqZGxAboOmSGn_QF?width=128&height=128&cropmode=none';
  @override
  Widget build(BuildContext context) {
    /* var globalController = Get.put(GlobalController());

    var cities = globalController.getCityToModel();
    Map<String, dynamic> jsonCities = {};
    List<Map<String, dynamic>> listofjson = [];
    cities.forEach(
      (element) {
        listofjson.add({"name": element.name, "id": element.id, "quantity": 0});
      },
    );
    jsonCities.addAll({'cities': listofjson});
    print(jsonCities); */

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
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
                  user!.photoURL ?? placeHolderPhoto,
                  fit: BoxFit.cover,
                ),
              ),
              verticalSpaceLarge,
              Text(
                user!.displayName ?? 'не має назви',
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
                margin: EdgeInsets.only(top: 40.h),
                borderCoplor: AppColors.primaryColor,
                height: 0.35.sh,
                width: 1.sw,
                backgroundColor: AppColors.primaryColorShade,
                child: GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) => Column(
                    children: [
                      controller.needs.isNotEmpty
                          //whet there is alreade need
                          ? AutoSizeText(
                              'Пам’ятайте, що ви можете додати лише одне оголошення.Якщо будь-яке з Ваших оголошень вже недійсне, видаліть його зі свого профілю',
                              maxLines: 6,
                              minFontSize: 18,
                              style: headingBoldStyle,
                            )
                          //whet there isn't any need
                          : AutoSizeText(
                              'Щоб отримати допомогу, натисніть кнопку нижче та заповніть анкету українською мовою.Якщо будь-яке з Ваших оголошень вже недійсне, видаліть його зі свого профілю. Пам’ятайте, що ви можете додати лише одне оголошення',
                              maxLines: 6,
                              minFontSize: 18,
                              style: headingBoldStyle,
                            ),
                      /* controller.needs.isNotEmpty
                          ? Container()
                          : */
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () async {
                            /* DbFirebase().createJsonCity(jsonCities); */

                           /*  var fechedNeedsDocument =
                                await DbFirebase().feachNeeds();

                            var cityNeed = 'warszawa';
                            Map<String, dynamic> needsDocument =
                                fechedNeedsDocument.data()!['needs']
                                    as Map<String, dynamic>;
                            List<dynamic> needs = needsDocument[cityNeed] ?? [];

                            needs.removeWhere(
                                (value) => value['city'] == 'Warszawa');
                            needsDocument.addAll(
                                {cityNeed: needs}); //update map with key city
                            needsDocument = {'needs': needsDocument};
                            print(needsDocument); */

                            Get.to(AddNeedView());
                          },
                          child: (Icon(
                            Icons.add_box_rounded,
                            size: 80.h,
                            color: AppColors.primaryColor,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
