import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/core/video_player.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/utils/constants/rp_text.dart';
import 'package:rein_player/utils/helpers/duration_helper.dart';

import '../models/video_audio_item.dart';

class ControlsController extends GetxController {
  static ControlsController get to => Get.find();

  final Player player = VideoPlayer.getInstance.player;

  RxDouble currentVideoProgress = 0.0.obs;
  Rx<Duration?> videoPosition = Rx<Duration?>(null);
  Rx<Duration?> videoDuration = Rx<Duration?>(null);

  void play() async {
    final currentVideoUrl = VideoAndControlController.to.currentVideoUrl;
    if(currentVideoUrl.isEmpty){
      await _pickFileAndPlay();
    }else{
      player.play();
    }
  }

  void pause() {
    player.pause();
  }

  void stop(){
    player.stop();
    _resetPlayer();
  }

  void open() async {
    await _pickFileAndPlay();
  }

  String getFormattedTimeWatched(){
    if(videoPosition.value == null) return RpText.defaultVideoTimeWatched;
    return RpDurationHelper.formatDuration(videoPosition.value!);
  }

  String getFormattedTotalDuration(){
    if(videoDuration.value == null) return RpText.defaultVideoDuration;
    return RpDurationHelper.formatDuration(videoDuration.value!);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
    } else {
      return "${twoDigits(minutes)}:${twoDigits(seconds)}";
    }
  }

  void updateProgressFromPosition(){
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

  void _resetPlayer(){
    videoDuration.value = null;
    videoPosition.value = null;
    currentVideoProgress.value = 0;
    VideoAndControlController.to.currentVideoUrl.value = "";
    VideoAndControlController.to.currentVideo.value = null;
  }

  Future<void> _pickFileAndPlay() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false
    );

    if(result != null){
      final file = result.files.single;
      if(file.path == null || file.extension == null) return;
      VideoOrAudioItem srcFile = VideoOrAudioItem(file.name, file.path!, file.extension!, size: file.size);
      VideoAndControlController.to.currentVideoUrl.value = srcFile.location;
      VideoAndControlController.to.currentVideo.value = srcFile;
      VideoAndControlController.to.loadVideoFromUrl(srcFile.location);
      player.play();
    }
  }
}