import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RpDeviceUtils {
  RpDeviceUtils._();

  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsects = View.of(context).viewInsets;
    return viewInsects.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsects = View.of(context).viewInsets;
    return viewInsects.bottom != 0;
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
