import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../core/video_player.dart';
import '../../../utils/constants/rp_sizes.dart';
import 'controls_controller.dart';

class VideoAndControlController extends GetxController {
  static VideoAndControlController get to => Get.find();

  final isVideoPlaying = false.obs;
  final isFullScreenMode = false.obs;
  Rx<String> currentVideoUrl = "".obs;

  // sizes
  Rx<double> videoAndControlScreenSize =
      RpSizes.minWindowAndControlScreenSize.obs;

  Player player = VideoPlayer.getInstance.player;
  late final videoPlayerController = VideoController(player);

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  void loadVideoFromUrl(String url) {
    player.open(Media(url));
    player.pause();

    /// playing listener
    player.stream.playing.listen((playing){
      isVideoPlaying.value = playing;
    });

    /// duration listener
    player.stream.duration.listen((duration) {
      ControlsController.to.videoDuration.value = duration;
    });

    /// current video position listener
    player.stream.position.listen((position){
      ControlsController.to.videoPosition.value = position;
      ControlsController.to.updateProgressFromPosition();
    });
  }
}
