import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../core/video_player.dart';
import '../../../utils/constants/rp_sizes.dart';

class VideoAndControlScreenController extends GetxController {
  static VideoAndControlScreenController get instance => Get.find();

  final isVideoToPlay = false.obs;
  final isFullScreenMode = false.obs;
  Rx<String> currentVideoOrAudioUrl = "".obs;

  // sizes
  Rx<double> videoAndControlScreenSize =
      RpSizes.minWindowAndControlScreenSize.obs;

  Player player = VideoPlayer.getInstance.player;
  late final videoPlayerController = VideoController(player);


  @override
  void onInit() {
    super.onInit();
    currentVideoOrAudioUrl.value =
        "https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4";
    if (currentVideoOrAudioUrl.value.isEmpty) return;
    loadVideoFromUrl(currentVideoOrAudioUrl.value);
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  void loadVideoFromUrl(String url) {
    player.open(Media(url));
    player.pause();
  }

  void activateFullScreenMode(BuildContext context) {
  //   if (isFullScreenMode.value) {
  //     Get.back();
  //     isFullScreenMode.value = false;
  //   } else {
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (BuildContext context) => RpFullScreenModeScreen()));
  //     isFullScreenMode.value = true;
  //     };
  }
}
