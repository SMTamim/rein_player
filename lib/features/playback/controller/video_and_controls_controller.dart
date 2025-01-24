import 'dart:ui';

import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:rein_player/features/playback/controller/volume_controller.dart';
import 'package:rein_player/features/playback/models/video_audio_item.dart';
import 'package:rein_player/utils/device/rp_device_utils.dart';
import 'package:rein_player/utils/helpers/media_helper.dart';
import 'package:window_manager/window_manager.dart';

import '../../../core/video_player.dart';
import '../../../utils/constants/rp_sizes.dart';
import 'controls_controller.dart';

class VideoAndControlController extends GetxController {
  static VideoAndControlController get to => Get.find();

  final isVideoPlaying = false.obs;
  final isFullScreenMode = false.obs;
  Rx<String> currentVideoUrl = "".obs;
  Rx<VideoOrAudioItem?> currentVideo = Rx<VideoOrAudioItem?>(null);

  Rx<double> videoAndControlScreenSize =
      RpSizes.minWindowAndControlScreenSize.obs;

  Player player = VideoPlayer.getInstance.player;
  late final videoPlayerController = VideoController(player);

  @override
  void dispose() async {
    super.dispose();
    await player.dispose();
  }

  void loadVideoFromUrl(String url)  async {
    currentVideoUrl.value = url;
    currentVideo.value = RpMediaHelper.getCurrentVideoInfoFromUrl(url);
    isVideoPlaying.value = false;
    ControlsController.to.currentVideoProgress.value = 0;
    ControlsController.to.videoDuration.value = null;
    ControlsController.to.videoPosition.value = null;

    VolumeController.to.currentVolume.value = RpSizes.defaultVolume;
    final windowSize = await RpDeviceUtils.getWindowFrameSize();
    if (windowSize.height == RpSizes.initialAppWindowSize.height &&
        windowSize.width == RpSizes.initialAppWindowSize.width) {
      RpDeviceUtils.setWindowFrameSize(RpSizes.initialVideoLoadedAppWidowSize);
    }

    await player.open(Media(url));
    await player.pause();

    /// playing listener
    player.stream.playing.listen((playing) {
      isVideoPlaying.value = playing;
      print('is video playing: ${isVideoPlaying.value}');
    });

    /// duration listener
    player.stream.duration.listen((duration) {
      ControlsController.to.videoDuration.value = duration;
    });

    /// current video position listener
    player.stream.position.listen((position) {
      ControlsController.to.videoPosition.value = position;
      ControlsController.to.updateProgressFromPosition();
    });
  }
}
