import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalController extends GetxController {
  GetStorage box = GetStorage();

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  bool isLoading = false;
  void toogleIsLoading() {
    isLoading = !isLoading;
    update();
  }


}
