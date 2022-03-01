import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/helpers/theme/text_styles.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  /* var controller = Get.put(HomeController()); */
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home view'),
    );
  }
}
