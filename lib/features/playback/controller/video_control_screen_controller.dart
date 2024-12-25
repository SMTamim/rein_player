import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

import '../../../core/video_player.dart';

class VideoAndControlScreenController extends GetxController {
  final isVideoToPlay = false.obs;
  final currentVideoOrAudioUrl = "".obs;

  Player player = VideoPlayer.getInstance.player;

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  void loadVideoFromUrl(String url){
    player.open(Media(url));
  }



}