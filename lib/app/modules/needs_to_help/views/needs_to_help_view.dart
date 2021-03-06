import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/modules/needs_to_help/widgets/needs_tile.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import '../../../../helpers/theme/form_field_styles.dart';
import '../../../../helpers/theme/text_styles.dart';
import '../../../../helpers/widgets/online_tribes/rounded_container.dart';
import '../../../infrastructure/fb_services/models/city_local_json.dart';
import '../controllers/needs_to_help_controller.dart';

class NeedsToHelpView extends GetView<NeedsToHelpController> {
  var globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              verticalSpaceMedium,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                horizontalSpaceExtraTiny,
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    )),
                Container(
                  width: 0.85.sw,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller.cityController,
                        decoration: outlineInputTextFormFieldStyle!.copyWith(
                          //city
                            label: Text(
                          'miasto',
                          style: textfieldLableStyle,
                        )),
                      ),
                      onSuggestionSelected: (City city) {
                        controller.cityController.text = city.name;
                        controller.getNeedsCity(city.name.toLowerCase());
                        //featch the needs fo currant city
                      },
                      itemBuilder: (_, City city) {
                        return ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text(
                            city.name,
                            style: headingBlackStyle,
                          ),
                          trailing: Text(city.quantity.toString()),
                        );
                      },
                      suggestionsCallback: (pattern) {
                        return controller.getSuggestions(pattern);
                      }),
                ),
              ]),
              Obx(
                () => RoundedContainer(
                  margin: EdgeInsets.zero,
                  borderCoplor: AppColors.primaryColor,
                  height: 0.84.sh,
                  width: 1.sw,
                  child: controller.needs.isEmpty
                      ? Center(
                          child: Column(
                          children: [
                            Image.asset(
                              'assets/graphics/search.png',
                            ),
                            verticalSpaceMedium,
                            Text(
                              'Brak aktywnych zg??osze?? w wybranym mie??cie',
                              style: headingBlackStyle,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ))
                      : ListView.builder(
                          itemCount: controller.needs.length,
                          itemBuilder: (_, index) {
                            return NeedsTile(need: controller.needs[index]);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
