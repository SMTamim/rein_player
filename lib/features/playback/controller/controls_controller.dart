import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/core/video_player.dart';

class ControlsController extends GetxController {
  static ControlsController get to => Get.find();

  final Player player = VideoPlayer.getInstance.player;

  void play() {
    player.play();
  }

  void pause() {
    player.pause();
  }
}
