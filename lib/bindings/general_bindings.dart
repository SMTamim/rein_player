import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/subtitle_controller.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';
import 'package:rein_player/features/playback/controller/volume_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';
import 'package:rein_player/features/settings/controller/settings_controller.dart';

import '../features/player_frame/controller/window_controller.dart';
import '../features/player_frame/controller/window_info_controller.dart';
import '../features/playlist/controller/album_content_controller.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(WindowController());
    Get.put(SubtitleController());
    Get.put(ControlsController());
    Get.put(VideoAndControlController());
    Get.put(WindowActionsController());
    Get.put(VolumeController());
    Get.put(WindowInfoController());
    Get.put(AlbumController());
    Get.put(AlbumContentController());
    Get.put(MainMenuController());
    Get.lazyPut(() => SettingsController());
  }
}