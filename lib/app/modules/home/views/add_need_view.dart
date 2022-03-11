import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';
import 'package:pomoc_ukrainie/helpers/theme/alert_styles.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';

import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/form_field_styles.dart';
import '../../../../helpers/widgets/online_tribes/form_field.dart';
import '../../../../helpers/widgets/online_tribes/one_line_textField.dart';
import '../../../infrastructure/translate_sevices/google_cloud_trans.dart';
import '../../models/city_local_json.dart';
import '../../models/need.dart';
import '../controllers/home_controller.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';
import 'user_profile.dart';

class AddNeedView extends GetView<HomeController> {
  var globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: globalController.unFocuseNode,
        child: Scaffold(
            floatingActionButton: IconButton(
              iconSize: 80,
              alignment: Alignment.center,
              icon: Icon(Icons.add_alert),
              onPressed: () async {
                await controller.postNeed().then((value) => Get.showSnackbar(
                      customSnackbar(
                          message: 'потреба була опублікована',
                          icon: Icons.file_download_done,
                          title: "done"),
                    ));
                await controller.getNeedsUser();
                Get.off(UserProfile());
              },
            ),
            body: GetBuilder<GlobalController>(
              builder: (globalGontroller) => Center(
                child: globalController.isLoading
                    ? CircularProgressIndicator()
                    : Form(
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
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: CustomTextField(
                                  validate: (text) =>
                                      controller.validateTextField(text),
                                  maxline: 4,
                                  minLine: 2,
                                  height: 80.h,
                                  width: 0.8.sw,
                                  controller: controller.adressController,
                                  color: AppColors.primaryColorShade,
                                  lableText: 'adress',
                                ),
                              ),
                              verticalSpaceSmall,
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 10,
                                ),
                                child: TypeAheadFormField<City>(
                                    validator: (text) {
                                      if (globalController
                                          .getSuggestions(text ?? '')
                                          .isEmpty) {
                                        //there is no such available city
                                        return 'такого доступного міста немає';
                                      }
                                      return controller
                                          .validateTextField(text ?? '');
                                    },
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: controller.cityController,
                                      decoration:
                                          outlineInputTextFormFieldStyle!
                                              .copyWith(
                                                  label: Text(
                                        //city
                                        'місто',
                                        style: textfieldLableStyle,
                                      )),
                                    ),
                                    onSuggestionSelected: (City city) {
                                      controller.cityController.text =
                                          city.name;
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
                                      return globalController
                                          .getSuggestions(pattern);
                                    }),
                              ),

                              /* GetBuilder<GlobalController>(
                      init: GlobalController(),
                      builder: (GlobalController globalController) {
                        print('rebuild getbuilder');
                        return Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: globalController.isLoading */
                              /* ? CircularProgressIndicator()
                                :*/

                              verticalSpaceSmall,
                              OneLineTextField(
                                  focusNode: controller.nameFocusNode,
                                  // onFieldSubmited: (_) {
                                  //   FocusScope.of(context).requestFocus(
                                  //       controller.titleFocusNode);
                                  // },
                                  keybordhType: TextInputType.name,
                                  validator: (text) {
                                    return controller
                                        .validateTextField(text ?? '');
                                  },
                                  //imię i nazwisko/"Ім'я та прізвище"
                                  lable: 'name',
                                  maxLenght: 25,
                                  controller: controller.nameController),
                              verticalSpaceSmall,
                              OneLineTextField(
                                // onFieldSubmited: (_) {
                                //     FocusScope.of(context).requestFocus(
                                //         controller.phoneFocusNode);
                                //   },
                                  focusNode: controller.titleFocusNode,
                                  maxLenght: 25,
                                  keybordhType: TextInputType.name,
                                  validator: (text) {
                                    return controller
                                        .validateTextField(text ?? '');
                                  },
                                  //potrzeba tytuł/"потрібен титул"
                                  lable: 'title',
                                  controller: controller.titleController),
                              verticalSpaceSmall,
                              OneLineTextField(
                                //  onFieldSubmited: (_) {
                                //     FocusScope.of(context).requestFocus(
                                //         controller.phoneFocusNode);
                                //   },
                                  focusNode: controller.descripotionFocusNode,
                                  maxLenght: 15,
                                  keybordhType: TextInputType.number,
                                  validator: (text) {
                                    return controller
                                        .validateTextField(text ?? '');
                                  },
                                  //nr.telefonu/ "телефонний номер"
                                  lable: 'phone number',
                                  controller:
                                      controller.contactNumberController),
                              verticalSpaceSmall,
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: CustomTextField(
                                  focusNode: controller.descripotionFocusNode,
                                  maxLenght: 400,
                                  validate: (text) =>
                                      controller.validateTextField(text),
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
            )),
      ),
    );
  }
}
/* Container(
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
                  ), */