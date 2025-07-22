import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FullscreenOverlayController extends GetxController {
  static FullscreenOverlayController get to => Get.find();

  final RxBool showTopMenu = false.obs;
  final RxBool showBottomMenu = false.obs;
  final RxBool hideCursor = false.obs;

  Timer? _hideTimer;
  Timer? _cursorHideTimer;

  static const double edgeThreshold = 80.0;

  static const Duration autoHideDelay = Duration(seconds: 3);
  static const Duration cursorHideDelay = Duration(seconds: 2);

  void onMouseMove(Offset position, Size screenSize) {
    final isAtTopEdge = position.dy <= edgeThreshold;
    final isAtBottomEdge = position.dy >= screenSize.height - edgeThreshold;

    hideCursor.value = false;

    _resetHideTimer();
    _resetCursorHideTimer();

    if (isAtTopEdge) {
      showTopMenu.value = true;
    } else if (!isAtBottomEdge) {
      showTopMenu.value = false;
    }

    if (isAtBottomEdge) {
      showBottomMenu.value = true;
    } else if (!isAtTopEdge) {
      showBottomMenu.value = false;
    }
  }

  void onMouseExit() {
    _startHideTimer();
    _startCursorHideTimer();
  }

  void showBothMenus() {
    showTopMenu.value = true;
    showBottomMenu.value = true;
    hideCursor.value = false;
    _resetHideTimer();
    _resetCursorHideTimer();
  }

  void hideBothMenus() {
    showTopMenu.value = false;
    showBottomMenu.value = false;
    _cancelHideTimer();
  }

  void _resetHideTimer() {
    _cancelHideTimer();
    _startHideTimer();
  }

  void _resetCursorHideTimer() {
    _cancelCursorHideTimer();
    _startCursorHideTimer();
  }

  void _startHideTimer() {
    _hideTimer = Timer(autoHideDelay, () {
      showTopMenu.value = false;
      showBottomMenu.value = false;
    });
  }

  void _startCursorHideTimer() {
    _cursorHideTimer = Timer(cursorHideDelay, () {
      hideCursor.value = true;
    });
  }

  void _cancelHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = null;
  }

  void _cancelCursorHideTimer() {
    _cursorHideTimer?.cancel();
    _cursorHideTimer = null;
  }

  @override
  void onClose() {
    _cancelHideTimer();
    _cancelCursorHideTimer();
    super.onClose();
  }
}
