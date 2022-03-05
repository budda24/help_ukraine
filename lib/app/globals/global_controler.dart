import 'package:get/get.dart';

class GlobalController extends GetxController {

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  bool isLoading = false;
  void toogleIsLoading() {
    isLoading = !isLoading;
    update();
  }


}
