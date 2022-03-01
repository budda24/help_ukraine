/* // Flutter imports:
import 'package:flutter/material.dart';
import 'package:path/path.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import '/app/widgets/loading_indicators.dart';

class FileController extends GetxController {
  String selectedImageName = '';
  XFile selectedFile = XFile('');

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (pickedFile != null) {
      selectedFile = pickedFile;
      selectedImageName = basename(pickedFile.path);
      update();
    } else {
      selectedFile = XFile('');
      selectedImageName = '';
      update();
    }
  }
}

class ImageUtilsView extends GetView {
  final String type;
  const ImageUtilsView({required this.type});

  @override
  Widget build(BuildContext context) {
    if (type == 'error') {
      return const Icon(
        Icons.image,
        color: Colors.white,
      );
    }
    if (type == 'loading_light') {
      return defaultLoadingIndicator;
    } else {
      return defaultLoadingIndicator;
    }
  }
}
 */