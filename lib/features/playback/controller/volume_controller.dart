import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';

import '../../../core/video_player.dart';

class VolumeController extends GetxController {
  static VolumeController get to => Get.find();

  RxDouble currentVolume = 0.0.obs;
  Player player = VideoPlayer.getInstance.player;

  @override
  onInit(){
    super.onInit();
    currentVolume.value = VideoAndControlController.to.currentVideoUrl.isEmpty ? 0 : RpSizes.defaultVolume;
  }

  void updateVolume(double volume) {
    if(VideoAndControlController.to.currentVideoUrl.isEmpty) return;
    currentVolume.value = volume;
    player.setVolume(volume * 100);
  }

  bool isVideoOnMute() => currentVolume.value == 0;

  void toggleVolumeMuteState(){
    if(isVideoOnMute()){
      currentVolume.value = RpSizes.defaultVolume;
    }else{
      currentVolume.value = 0;
    }
  }
}