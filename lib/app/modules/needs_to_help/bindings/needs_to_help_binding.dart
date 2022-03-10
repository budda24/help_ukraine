import 'package:get/get.dart';

import '../controllers/needs_to_help_controller.dart';

class NeedsToHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NeedsToHelpController>(
      () => NeedsToHelpController(),
    );
  }
}
