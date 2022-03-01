/* // Package imports:
import 'package:get/get.dart';

// Project imports:
import '/app/controllers/dialog_controller.dart';
import '/app/controllers/global_controller.dart';

class ControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GlobalController>(
      () => GlobalController(),
    );

    Get.lazyPut<DialogController>(
      () => DialogController(),
    );
  }
} */
