import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

import '../../../core/video_player.dart';

class VolumeController extends GetxController {
  static VolumeController get to => Get.find();

  final storage = RpLocalStorage();

  RxDouble currentVolume = 0.0.obs;
  double previousVolume = 0;
  Player player = VideoPlayer.getInstance.player;

  @override
  onInit() async {
    super.onInit();
    final savedVolume = await storage.readData(RpKeysConstants.volumeStorageKey);
    currentVolume.value = savedVolume ?? RpSizes.defaultVolume;
  }

  bool isVideoOnMute() => currentVolume.value == 0;

  Future<void> updateVolume(double volume) async {
    if(VideoAndControlController.to.currentVideoUrl.isEmpty) return;
    currentVolume.value = volume;
    await player.setVolume(volume * 100);
  }

  void toggleVolumeMuteState(){
    if(isVideoOnMute()){
      updateVolume(previousVolume);
    }else{
      previousVolume = currentVolume.value;
      updateVolume(0);
    }
  }

  Future<void> dumpVolumeToStorage() async {
    await storage.saveData(RpKeysConstants.volumeStorageKey, currentVolume.value);
  }

  void resetVolume(){
    currentVolume.value = 0;
  }
}