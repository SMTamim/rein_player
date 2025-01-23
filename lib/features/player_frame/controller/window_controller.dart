import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class WindowController extends GetxController with WindowListener {
  static WindowController get to => Get.find();
  Size currentWindowSize = Size.zero;

  @override
  void onInit() {
    windowManager.addListener(this);
    super.onInit();
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();
  }
}
