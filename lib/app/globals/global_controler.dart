import 'package:get/get.dart';

class GlobalController extends GetxController {

 
  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}