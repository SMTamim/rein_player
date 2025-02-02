import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as path;
import 'package:rein_player/core/video_player.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playback/controller/volume_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/playlist/controller/album_content_controller.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/features/playlist/models/playlist_item.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';
import 'package:rein_player/utils/constants/rp_text.dart';
import 'package:rein_player/utils/helpers/duration_helper.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';
import 'package:window_manager/window_manager.dart';

import '../models/video_audio_item.dart';

class ControlsController extends GetxController {
  static ControlsController get to => Get.find();

  final storage = RpLocalStorage();
  final Player player = VideoPlayer.getInstance.player;

  Timer? _seekDebounceTimer;

  RxDouble currentVideoProgress = 0.0.obs;
  RxBool isProgressIndicatorOnDrag = false.obs;

  Rx<Duration?> videoPosition = Rx<Duration?>(null);
  Rx<Duration?> videoDuration = Rx<Duration?>(null);

  void play() async {
    final currentVideoUrl = VideoAndControlController.to.currentVideoUrl;
    if (currentVideoUrl.isEmpty) {
      await _pickFileAndPlay();
    } else {
      await player.play();
    }
  }

  void pause() async {
    await player.pause();
  }

  void stop() async {
    await player.stop();
    _resetPlayer();
  }

  void pauseOrPlay() async {
    await player.playOrPause();
  }

  void open() async {
    await _pickFileAndPlay();
  }

  void goNextItemInPlaylist() {
    AlbumContentController.to.goNextItemInPlaylist();
  }

  void goPreviousItemInPlaylist() {
    AlbumContentController.to.goPreviousItemInPlaylist();
  }

  String getFormattedTimeWatched() {
    if (videoPosition.value == null) return RpText.defaultVideoTimeWatched;
    return RpDurationHelper.formatDuration(videoPosition.value!);
  }

  Duration _calculateSeekTime({required double percentage}) {
    final duration = videoDuration.value;
    if (duration == null) {
      return const Duration(seconds: 10);
    }
    return Duration(seconds: (duration.inSeconds * percentage).round());
  }

  Future<void> seekBackward() async {
    final seekTime = _calculateSeekTime(percentage: 0.01);
    final position = videoPosition.value?.inSeconds ?? 0;
    final seekTo = position - seekTime.inSeconds;
    if (seekTo < 0) return;
    await player.seek(Duration(seconds: seekTo));
  }

  Future<void> seekForward() async {
    final seekTime = _calculateSeekTime(percentage: 0.01);
    final position = videoPosition.value?.inSeconds ?? 0;
    final seekTo = position + seekTime.inSeconds;
    await player.seek(Duration(seconds: seekTo));
  }

  Future<void> bigSeekBackward() async {
    final seekTime = _calculateSeekTime(percentage: 0.05);
    final position = videoPosition.value?.inSeconds ?? 0;
    final seekTo = position - seekTime.inSeconds;
    if (seekTo < 0) return;
    await player.seek(Duration(seconds: seekTo));
  }

  Future<void> bigSeekForward() async {
    final seekTime = _calculateSeekTime(percentage: 0.05);
    final position = videoPosition.value?.inSeconds ?? 0;
    final seekTo = position + seekTime.inSeconds;
    await player.seek(Duration(seconds: seekTo));
  }

  String getFormattedTotalDuration() {
    if (videoDuration.value == null) return RpText.defaultVideoDuration;
    return RpDurationHelper.formatDuration(videoDuration.value!);
  }

  void videoOnPanUpdate(RenderBox box, DragUpdateDetails details){
    double localDx = details.localPosition.dx;
    double totalWidth = box.size.width;
    double newProgress = (localDx / totalWidth).clamp(0.0, 1.0);

    currentVideoProgress.value = newProgress;
    isProgressIndicatorOnDrag.value = true;
  }

  Future<void> videoOnPanEnd() async {
    final progress = currentVideoProgress.value;
    if (videoDuration.value == null) return;
    final duration = videoDuration.value!;
    final seekPosition = Duration(seconds: (progress * duration.inSeconds).toInt());

    await player.seek(seekPosition);
    isProgressIndicatorOnDrag.value = false;
  }

  Future<void> videoOnTapDown(RenderBox box, TapDownDetails details) async {
    double localDx = details.localPosition.dx;
    double totalWidth = box.size.width;
    double newProgress = (localDx / totalWidth).clamp(0.0, 1.0);

    ControlsController.to.currentVideoProgress.value = newProgress;
    if (ControlsController.to.videoDuration.value != null) {
      final duration = ControlsController.to.videoDuration.value!;
      final seekPosition = Duration(seconds: (newProgress * duration.inSeconds).toInt());
      await player.seek(seekPosition);
    }
  }


  void updateProgressFromPosition() {
    if (videoPosition.value == null ||
        videoDuration.value == null ||
        videoDuration.value!.inMilliseconds == 0 || isProgressIndicatorOnDrag.value) return;
    double progress = videoPosition.value!.inMilliseconds / videoDuration.value!.inMilliseconds;
    progress = progress.clamp(0.0, 1.0);
    currentVideoProgress.value = progress;
  }

  Future<void> updateVideoProgress(double progress, {bool delayUiUpdate = false}) async {
    if (videoDuration.value == null) return;

    currentVideoProgress.value = progress;
    final duration = videoDuration.value!;
    final seekPosition = Duration(seconds: (progress * duration.inSeconds).toInt());

    if (delayUiUpdate) {
      _seekDebounceTimer?.cancel();
      _seekDebounceTimer = Timer(const Duration(milliseconds: 300), () async {
        await player.seek(seekPosition);
      });
    } else {
      _seekDebounceTimer?.cancel();
      await player.seek(seekPosition);
    }
  }

  void _resetPlayer() {
    videoDuration.value = null;
    videoPosition.value = null;
    currentVideoProgress.value = 0;
    VideoAndControlController.to.currentVideoUrl.value = "";
    VideoAndControlController.to.currentVideo.value = null;
    VolumeController.to.currentVolume.value = 0;
    PlaylistController.to.isPlaylistWindowOpened.value = false;
    windowManager.setSize(RpSizes.initialAppWindowSize);
  }

  void resetVideoProgress() {
    currentVideoProgress.value = 0;
    videoPosition.value = null;
    videoDuration.value = null;
  }

  Future<void> _pickFileAndPlay() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: false);

    if (result != null) {
      final file = result.files.single;
      if (file.path == null || file.extension == null) return;
      final filePath = file.path!;

      VideoOrAudioItem srcFile = VideoOrAudioItem(file.name, filePath, size: file.size);
      VideoAndControlController.to.loadVideoFromUrl(srcFile);
      AlbumContentController.to.currentContent.clear();
      AlbumContentController.to.addToCurrentPlaylistContent(
        PlaylistItem(name: file.name, location: filePath, isDirectory: false),
      );
      AlbumController.to.updateSelectedAlbumIndex(0);

      AlbumController.to.updateAlbumCurrentItemToPlay(filePath);
      await AlbumController.to.dumpAllAlbumsToStorage();

      /// set the default album location
      await AlbumController.to.setDefaultAlbum(filePath, currentItemToPlay: filePath);
      await AlbumContentController.to
          .loadSimilarContentInDefaultAlbum(path.basename(filePath), path.dirname(filePath));
      AlbumContentController.to.updatePlaylistItemDuration(filePath);

      WindowActionsController.to.maximizeWindow();
      await player.play();
    }
  }
}
