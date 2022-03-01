import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return GestureDetector(
      onTap: controller.unFocuseNode,
      child: Scaffold(
        /* backgroundColor: AppColors.primaryColorShade, */
        floatingActionButton: IconButton(
          iconSize: 80,
          alignment: Alignment.center,
          icon: Icon(Icons.add_alert),
          onPressed: () {
            Get.to(NeedsView());
            //add need
          },
        ),
        body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/3-clipboard.png',
                ),
              ),
              OneLineTextField(
                  //imię i nazwisko/
                  lable: "Ім'я та прізвище",
                  controller: controller.nameController),
              OneLineTextField(
                  //potrzeba tytuł/
                  lable: "потрібен титул",
                  controller: controller.needController),
              OneLineTextField(
                  //nr.telefonu/
                  lable: "телефонний номер",
                  controller: controller.phoneNumberController),
              Container(
                /*  margin: EdgeInsets.only(top: 30.h),
                height: 50.h,
                width: 320.w, */
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: controller.cityController,
                      decoration: outlineInputTextFormFieldStyle!.copyWith(
                          label: Text(
                        'місто',
                        style: textfieldLableStyle,
                      )),
                    ),
                    onSuggestionSelected: (City city) {
                      controller.cityController.text = city.name;
                    },
                    itemBuilder: (_, City city) {
                      return Text(
                        city.name,
                        style: headingBlackStyle,
                      );
                    },
                    suggestionsCallback: (pattern) {
                      return controller.getSuggestions(pattern);
                    }),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: CustomTextField(
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
    );
  }
}
