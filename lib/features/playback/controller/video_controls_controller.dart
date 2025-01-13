import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/core/video_player.dart';

class ControlsController extends GetxController {
  static ControlsController get to => Get.find();

  final Player player = VideoPlayer.getInstance.player;

  RxDouble currentVideoProgress = 0.0.obs;
  Rx<Duration?> videoPosition = Rx<Duration?>(null);
  Rx<Duration?> videoDuration = Rx<Duration?>(null);

  @override
  void onInit() {
    super.onInit();
    /// duration listener
    player.stream.duration.listen((duration) {
      videoDuration.value = duration;
    });

    /// current video position listener
    player.stream.position.listen((position){
      videoPosition.value = position;
      _updateProgressFromPosition();
    });
  }

  void play() {
    player.play();
  }

  void pause() {
    player.pause();
  }

  // String getTimeWatchedAndTotalDuration(){
  //
  // }

  void _updateProgressFromPosition(){
    if(videoPosition.value == null || videoDuration.value == null) return;
    double progress = videoPosition.value!.inMilliseconds / videoDuration.value!.inMilliseconds;
    progress = progress.clamp(0.0, 1.0);
    currentVideoProgress.value = progress;
  }

  void updateVideoProgress(double progress) {
    if(videoDuration.value == null) return;
    currentVideoProgress.value = progress;
    final duration = videoDuration.value!;
    final seekPosition = Duration(seconds: (progress * duration.inSeconds).toInt());
    currentVideoProgress.value = progress;
    player.seek(seekPosition);
  }

  void resetVideoProgress() {
    currentVideoProgress.value = 0.0;
    videoDuration.value = null;
  }
}