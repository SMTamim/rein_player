import 'dart:async';
import 'package:get/get.dart';
import 'package:rein_player/core/video_player.dart';

class PlaybackSpeedController extends GetxController {
  static PlaybackSpeedController get to => Get.find();

  final List<double> speedOptions = [
    0.25,
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    1.75,
    2.0
  ];

  final RxInt currentSpeedIndex = 3.obs;

  final Rx<double> currentSpeed = 1.0.obs;

  final RxBool showOverlay = false.obs;

  Timer? _overlayTimer;

  void increaseSpeed() {
    if (currentSpeedIndex.value < speedOptions.length - 1) {
      currentSpeedIndex.value++;
      updateSpeed(speedOptions[currentSpeedIndex.value]);
    }
  }

  void decreaseSpeed() {
    if (currentSpeedIndex.value > 0) {
      currentSpeedIndex.value--;
      updateSpeed(speedOptions[currentSpeedIndex.value]);
    }
  }

  void updateSpeed(double speed) {
    currentSpeed.value = speed;
    VideoPlayer.getInstance.player.setRate(speed);

    showOverlay.value = true;

    _overlayTimer?.cancel();
    _overlayTimer = Timer(const Duration(seconds: 2), () {
      showOverlay.value = false;
    });
  }

  String get speedText => '${currentSpeed.value}x';
}
