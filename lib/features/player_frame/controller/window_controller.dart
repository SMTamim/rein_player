import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';
import 'package:window_manager/window_manager.dart';

class WindowController extends GetxController with WindowListener {
  static WindowController get to => Get.find();

  final storage = RpLocalStorage();

  Rx<Size> currentWindowSize = Size.zero.obs;
  RxBool isWindowLoaded = false.obs;

  @override
  void onInit() {
    windowManager.addListener(this);
    super.onInit();
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();
    currentWindowSize.value = await windowManager.getSize();

    /// boolean to load the window before rendering the video
    final sizeToCompareWith = AlbumController.to.isMediaInDefaultAlbumLocation()
        ? RpSizes.initialVideoLoadedAppWidowSize
        : RpSizes.initialAppWindowSize;
    isWindowLoaded.value = currentWindowSize.value.width >= sizeToCompareWith.width;
  }
}
