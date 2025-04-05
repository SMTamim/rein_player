import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/volume_controller.dart';
import 'package:window_manager/window_manager.dart';

class WindowActionsController extends GetxController {
  static WindowActionsController get to => Get.find();

  final Rx<bool> isPinned = false.obs;
  final Rx<bool> isFullScreenMode = false.obs;

  bool isMaximize = false;

  Future<void> togglePin() async {
    isPinned.value = !isPinned.value;
    await windowManager.setAlwaysOnTop(isPinned.value);
  }

  void minimizeWindow() {
    windowManager.minimize();
  }

  void maximizeWindow() {
    windowManager.maximize();
  }

  void maximizeOrRestoreWindow() {
    isMaximize = !isMaximize;
    appWindow.maximizeOrRestore();
  }

  void toggleFullScreenWindow() async {
    isFullScreenMode.value = !isFullScreenMode.value;
    if (isFullScreenMode.value) {
      isPinned.value = true;
      await windowManager.setFullScreen(true);
      await windowManager.setAlwaysOnTop(isPinned.value);
    } else {
      isPinned.value = false;
      await windowManager.setFullScreen(false);
      await windowManager.setAlwaysOnTop(isPinned.value);
    }
  }

  void exitFullscreen() async {
    if (isFullScreenMode.value) {
      isFullScreenMode.value = false;
      await windowManager.setFullScreen(false);
      // Reset always on top to match pinned state
      await windowManager.setAlwaysOnTop(isPinned.value);
    }
  }

  void closeWindow() async {
    await VolumeController.to.dumpVolumeToStorage();
    windowManager.close();
  }

  void toggleWindowSize() {
    appWindow.maximizeOrRestore();
  }
}