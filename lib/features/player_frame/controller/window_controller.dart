import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:window_manager/window_manager.dart';

import '../../../utils/constants/rp_sizes.dart';

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
    /// checking it maximize to fix maximize and restore
    /// respecting the previous window size
    // if(WindowActionsController.to.isMaximize) return;
    // currentWindowSize = await windowManager.getSize();
    //
    // final adjustedWidth = RpSizes.minWindowAndControlScreenSize +
    //     (PlaylistController.to.isPlaylistWindowOpened.value
    //         ? PlaylistController.to.playlistWindowWidth.value
    //         : -PlaylistController.to.playlistWindowWidth.value);
    //
    // windowManager.setMinimumSize(Size(adjustedWidth, currentWindowSize.height));
  }
}
