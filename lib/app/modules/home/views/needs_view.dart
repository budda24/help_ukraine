import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/modules/home/models/need.dart';
import 'package:pomoc_ukrainie/app/modules/home/views/needs_details_screen.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';

import '../../../../helpers/theme/form_field_styles.dart';
import '../../../../helpers/theme/text_styles.dart';
import '../../../../helpers/widgets/online_tribes/rounded_container.dart';
import '../controllers/home_controller.dart';
import '../models/city.dart';

class NeedsView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var need = Need(
        needTitle: 'need food',
        contact: 3332245,
        city: 'Warszawa',
        email: 'Test@test.com',
        needDescription: '');
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              verticalSpaceMedium,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                horizontalSpaceExtraTiny,
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_off_rounded,
                      size: 40,
                    )),
                Container(
                  width: 0.85.sw,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller.cityController,
                        decoration: outlineInputTextFormFieldStyle!.copyWith(
                            label: Text(
                          'Miasto',
                          style: textfieldLableStyle,
                        )),
                      ),
                      onSuggestionSelected: (City city) {
                        controller.cityController.text = city.name;
                      },
                      itemBuilder: (_, City city) {
                        return ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text(
                            city.name,
                            style: headingBlackStyle,
                          ),
                        );
                      },
                      suggestionsCallback: (pattern) {
                        return controller.getSuggestions(pattern);
                      }),
                ),
              ]),
              RoundedContainer(
                borderCoplor: AppColors.primaryColor,
                height: 0.84.sh,
                width: 1.sw,
                /* bcColor: AppColors.primaryColorShade, */
                child: ListView.builder(
                  itemCount: 23,
                  itemBuilder: (context, item) {
                    return Center(
                        child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(15.0.r),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        onTap: () {
                          Get.to(NeedsDetailsScreen());
                        },
                        selectedTileColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        leading: Icon(
                          Icons.add_alert_sharp,
                          size: 26,
                        ),
                        title: Text(
                          'need.needTitle',
                          style: headingBlackStyle,
                        ),
                      ),
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
