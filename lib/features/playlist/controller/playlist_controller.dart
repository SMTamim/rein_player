import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_control_screen_controller.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';

class PlaylistController extends GetxController {
  static PlaylistController get instance => Get.find();

  final isPlaylistWindowOpened = false.obs;
  Rx<double> playlistWindowWidth = RpSizes.minPlaylistWindowSize.obs;

  void togglePlaylistWindow(){
    isPlaylistWindowOpened.value = !isPlaylistWindowOpened.value;

  }

  void updatePlaylistWindowSizeOnDrag(DragUpdateDetails details) {
    final dx = details.delta.dx;
    final videoAndControlScreenSize =
        Get.find<VideoAndControlScreenController>().videoAndControlScreenSize.value;


    if (dx > 0 && playlistWindowWidth.value > RpSizes.minPlaylistWindowSize) {
      playlistWindowWidth.value -= dx;
    } else if (dx < 0 &&
        videoAndControlScreenSize >
            RpSizes.minWindowAndControlScreenSize) {
      playlistWindowWidth.value -= dx;
    }
  }
}
