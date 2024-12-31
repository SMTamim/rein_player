import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';
import 'package:rein_player/features/playback/controller/video_control_screen_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(PlaylistController());
    Get.put(ControlsController());
    Get.put(VideoAndControlScreenController());
    Get.put(WindowActionsController());
  }
}