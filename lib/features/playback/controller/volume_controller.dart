import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

import '../../../core/video_player.dart';

class VolumeController extends GetxController {
  static VolumeController get to => Get.find();

  RxDouble currentVolume = 0.5.obs;
  Player player = VideoPlayer.getInstance.player;

  void updateVolume(double volume) {
    currentVolume.value = volume;
    player.setVolume(volume * 100);
  }

  bool isVideoOnMute() => currentVolume.value == 0;

  void toggleVolumeMuteState(){
    if(isVideoOnMute()){
      currentVolume.value = 0.5;
    }else{
      currentVolume.value = 0;
    }
  }
}