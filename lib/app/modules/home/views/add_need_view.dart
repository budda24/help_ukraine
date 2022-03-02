import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';

import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/form_field_styles.dart';
import '../../../../helpers/widgets/online_tribes/form_field.dart';
import '../../../../helpers/widgets/online_tribes/one_line_textField.dart';
import '../controllers/home_controller.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import '../models/city.dart';
import 'needs_view.dart';

class HomeView extends GetView<HomeController> {
  var controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 809),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return SafeArea(
      child: GestureDetector(
        onTap: controller.unFocuseNode,
        child: Scaffold(
          /* backgroundColor: AppColors.primaryColorShade, */
          floatingActionButton: IconButton(
            iconSize: 80,
            alignment: Alignment.center,
            icon: Icon(Icons.add_alert),
            onPressed: () {
              controller.postNeed();
              Get.to(NeedsView());

              //add need
            },
          ),
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verticalSpaceMedium,
                  Image.asset(
                    'assets/data.png',
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    child: TypeAheadFormField(
                        validator: (text) {
                          if (controller.getSuggestions(text ?? '').isEmpty) {
                            //there is no such available city
                            return 'такого доступного міста немає';
                          }
                          return controller.validateTextField(text ?? '');
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: controller.cityController,
                          decoration: outlineInputTextFormFieldStyle!.copyWith(
                              label: Text(
                            //city
                            'місто',
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
                  verticalSpaceSmall,
                  OneLineTextField(
                      keybordhType: TextInputType.name,
                      validator: (text) {
                        return controller.validateTextField(text ?? '');
                      },
                      //imię i nazwisko/
                      lable: "Ім'я та прізвище",
                      controller: controller.nameController),
                      verticalSpaceSmall,
                  OneLineTextField(
                      validator: (text) {
                        return controller.validateTextField(text ?? '');
                      },
                      //potrzeba tytuł/
                      lable: "потрібен титул",
                      controller: controller.needTitleController),
                      verticalSpaceSmall,
                  OneLineTextField(
                      keybordhType: TextInputType.number,
                      validator: (text) {
                        return controller.validateTextField(text ?? '');
                      },
                      //nr.telefonu/
                      lable: "телефонний номер",
                      controller: controller.contactNumberController),
                    verticalSpaceSmall,
                  Container(

                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: CustomTextField(
                      validate: (text) => controller.validateTextField(text),
                      maxline: 10,
                      minLine: 5,
                      height: 120.h,
                      width: 0.8.sw,
                      controller: controller.descriptionController,
                      color: AppColors.primaryColorShade,
                      lableText: 'опис',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
