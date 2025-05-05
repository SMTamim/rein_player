import 'dart:io';

import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:rein_player/features/developer/controller/developer_log_controller.dart';
import 'package:rein_player/features/playback/controller/subtitle_controller.dart';
import 'package:rein_player/features/playback/controller/volume_controller.dart';
import 'package:rein_player/features/playback/models/video_audio_item.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/playlist/controller/album_content_controller.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/features/playlist/models/playlist_item.dart';
import 'package:rein_player/utils/device/rp_device_utils.dart';
import 'package:rein_player/utils/helpers/media_helper.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

import '../../../core/video_player.dart';
import '../../../utils/constants/rp_sizes.dart';
import 'controls_controller.dart';

class VideoAndControlController extends GetxController {
  static VideoAndControlController get to => Get.find();

  final storage = RpLocalStorage();

  final isVideoPlaying = false.obs;
  final isVideoCompleted = false.obs;
  final isFullScreenMode = false.obs;
  Rx<String> currentVideoUrl = "".obs;
  Rx<VideoOrAudioItem?> currentVideo = Rx<VideoOrAudioItem?>(null);

  Rx<double> videoAndControlScreenSize =
      RpSizes.minWindowAndControlScreenSize.obs;

  Player player = VideoPlayer.getInstance.player;
  late final videoPlayerController = VideoController(player);
  RxDouble reloadPlayerView = 0.0.obs;

  @override
  void dispose() async {
    super.dispose();
    await videoPlayerController.player.dispose();
    videoPlayerController.player.dispose();
  }

  /// load media file from url
  Future<void> loadVideoFromUrl(VideoOrAudioItem media,
      {bool play = true}) async {
    // if (currentVideo.value?.location == media.location) return;
    currentVideoUrl.value = media.location;
    currentVideo.value = media;
    ControlsController.to.resetVideoProgress();

    VolumeController.to.currentVolume.value =
        VolumeController.to.currentVolume.value == 0
            ? RpSizes.defaultVolume
            : VolumeController.to.currentVolume.value;

    final windowSize = await RpDeviceUtils.getWindowFrameSize();
    if (windowSize.height == RpSizes.initialAppWindowSize.height &&
        windowSize.width == RpSizes.initialAppWindowSize.width) {
      await RpDeviceUtils.setWindowFrameSize(
          RpSizes.initialVideoLoadedAppWidowSize);
    }

    /// Add media streams to gather info
    addMediaStreamsForInfo();
    await videoPlayerController.player.open(Media(media.location));
    await VolumeController.to.ensureVolume();

    if (!SubtitleController.to.isSubtitleEnabled.value) {
      await SubtitleController.to.disableSubtitle();
    }

    if (play) {
      await videoPlayerController.player.play();
    } else {
      await videoPlayerController.player.pause();
    }
  }

  void addMediaStreamsForInfo() {
    /// playing listener
    player.stream.playing.listen((playing) {
      isVideoPlaying.value = playing;
    });

    /// duration listener
    player.stream.duration.listen((duration) {
      ControlsController.to.videoDuration.value = duration;
    });

    /// current video position listener
    player.stream.position.listen((position) {
      ControlsController.to.videoPosition.value = position;
      ControlsController.to.updateProgressFromPosition();
    });

    /// current video completion status
    player.stream.completed.listen((isCompleted) async {
      if (isCompleted && !isVideoCompleted.value) {
        isVideoCompleted.value = true;
        if (AlbumContentController.to.currentContent.length > 1) {
          await AlbumContentController.to.goNextItemInPlaylist();
        }
        isVideoCompleted.value = false;
      }
    });
  }

  Future<void> handleCommandLineArgs(List<String> args) async {
    if (args.isEmpty) return;

    String filePath = args.first.trim();
    ControlsController.to.resetPlayer();

    if (filePath.isNotEmpty) {
      try {
        final media = VideoOrAudioItem(
          filePath.split('/').last,
          filePath,
        );

        await AlbumController.to.setDefaultAlbum(
          filePath,
          currentItemToPlay: filePath,
        );
        await AlbumController.to.dumpAllAlbumsToStorage();

        final playlistItem = PlaylistItem(
          name: filePath.split('/').last,
          location: filePath,
          isDirectory: await FileSystemEntity.isDirectory(filePath),
          type: RpMediaHelper.getPlaylistItemType(filePath),
        );

        AlbumContentController.to
            .addItemsToPlaylistContent([playlistItem], clearBefore: true);

        await loadVideoFromUrl(media);
        WindowActionsController.to.maximizeWindow();
      } catch (e) {
        DeveloperLogController.to.log("Error handling file: $e");
      }
    }
  }
}
