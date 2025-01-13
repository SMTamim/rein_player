import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

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

  @override
  void onInit() {
    super.onInit();
    currentVideoOrAudioUrl.value =
        "/home/amalitechpc4100602/disk_d/courses/designship/Module 1- Welcome/2. Install Files.mp4";
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
}
