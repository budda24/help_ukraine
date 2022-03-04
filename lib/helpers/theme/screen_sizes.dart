
import 'package:flutter/material.dart';

class ScreenSizes {
  final BoxConstraints constraints;
  ScreenSizes({required this.constraints});

  Size getScreenSize() {
    return constraints.biggest.width > 1200
        ? const Size(1920, 1080)
        : constraints.biggest.width > 800 && constraints.biggest.width < 1200
            ? const Size(1366, 768)
            : const Size(428, 926);
  }
}
