import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

import '../../../core/video_player.dart';
import '../../../utils/constants/rp_sizes.dart';

class VideoAndControlController extends GetxController {
  static VideoAndControlController get to => Get.find();

  final isVideoToPlay = false.obs;
  final isFullScreenMode = false.obs;
  Rx<String> currentVideoOrAudioUrl = "".obs;

  // sizes
  Rx<double> videoAndControlScreenSize =
      RpSizes.minWindowAndControlScreenSize.obs;

  Player player = VideoPlayer.getInstance.player;
  late final videoPlayerController = VideoController(player);

  //volume and video progress
  RxDouble currentVolume = 0.5.obs;
  RxDouble currentVideoProgress = 0.0.obs;
  Rx<Duration?> videoPosition = Rx<Duration?>(null);
  Rx<Duration?> videoDuration = Rx<Duration?>(null);

  @override
  void onInit() {
    super.onInit();
    currentVideoOrAudioUrl.value =
        "/home/amalitechpc4100602/disk_d/courses/designship/Module 1- Welcome/2. Install Files.mp4";
    if (currentVideoOrAudioUrl.value.isEmpty) return;
    loadVideoFromUrl(currentVideoOrAudioUrl.value);

    /// duration listener
    player.stream.duration.listen((duration) {
      videoDuration.value = duration;
    });

    /// current video position listener
    player.stream.position.listen((position){
      videoPosition.value = position;
      _updateProgressFromPosition();
    });
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

  void updateVolume(double volume) {
    currentVolume.value = volume;
    player.setVolume(volume * 100);
  }

  void _updateProgressFromPosition(){
    if(videoPosition.value == null || videoDuration.value == null) return;
    double progress = videoPosition.value!.inMilliseconds / videoDuration.value!.inMilliseconds;
    progress = progress.clamp(0.0, 1.0);
    currentVideoProgress.value = progress;
  }

  void updateVideoProgress(double progress) {
    if(videoDuration.value == null) return;
      currentVideoProgress.value = progress;
      final duration = videoDuration.value!;
      final seekPosition = Duration(seconds: (progress * duration.inSeconds).toInt());
      currentVideoProgress.value = progress;
      player.seek(seekPosition);
  }

  void resetVideoProgress() {
    currentVideoProgress.value = 0.0;
    videoDuration.value = null;
  }
}
