import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

class VolumeController extends GetxController {
  static VolumeController get to => Get.find();

  final storage = RpLocalStorage();
  final double scrollStep = 0.05;

  // UI volume range: 0.0 to 1.0
  RxDouble currentVolume = 0.0.obs;
  double previousVolume = 0;
  Player player = VideoAndControlController.to.videoPlayerController.player;

  // Maximum volume to set on the player (150%)
  final double maxPlayerVolume = 200.0;

  @override
  onInit() async {
    super.onInit();
    final savedVolume =
        await storage.readData(RpKeysConstants.volumeStorageKey);
    currentVolume.value = savedVolume ?? RpSizes.defaultVolume;
    await _applyVolumeToPlayer();
  }

  bool isVideoOnMute() => currentVolume.value == 0;

  // Convert UI volume (0-1) to player volume (0-150)
  double _uiVolumeToPlayerVolume(double uiVolume) {
    return uiVolume * maxPlayerVolume;
  }

  // Apply the current UI volume to the player
  Future<void> _applyVolumeToPlayer() async {
    double playerVolume = _uiVolumeToPlayerVolume(currentVolume.value);
    await player.setVolume(playerVolume);
  }

  Future<void> updateVolume(double volume) async {
    if (VideoAndControlController.to.currentVideoUrl.isEmpty) return;
    // Ensure volume is between 0 and 1 for UI
    currentVolume.value = volume.clamp(0.0, 1.0);
    await _applyVolumeToPlayer();
  }

  void toggleVolumeMuteState() {
    if (isVideoOnMute()) {
      updateVolume(previousVolume);
    } else {
      previousVolume = currentVolume.value;
      updateVolume(0);
    }
  }

  void onScrollUpdateVolume(PointerScrollEvent scrollEvent) {
    final bool scrollUp = scrollEvent.scrollDelta.dy < 0;
    double delta = scrollUp ? scrollStep : -scrollStep;
    updateVolume((currentVolume.value + delta).clamp(0.0, 1.0));
  }

  Future<void> dumpVolumeToStorage() async {
    await storage.saveData(
        RpKeysConstants.volumeStorageKey, currentVolume.value);
  }

  void resetVolume() {
    currentVolume.value = 0;
    player.setVolume(0);
  }

  Future<void> ensureVolume() async {
    await _applyVolumeToPlayer();
  }
}
