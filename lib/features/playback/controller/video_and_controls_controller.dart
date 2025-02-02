import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:rein_player/features/playback/controller/subtitle_controller.dart';
import 'package:rein_player/features/playback/controller/volume_controller.dart';
import 'package:rein_player/features/playback/models/video_audio_item.dart';
import 'package:rein_player/features/playlist/controller/album_content_controller.dart';
import 'package:rein_player/features/settings/models/settings.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';
import 'package:rein_player/utils/device/rp_device_utils.dart';
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

  Rx<double> videoAndControlScreenSize = RpSizes.minWindowAndControlScreenSize.obs;

  Player player = VideoPlayer.getInstance.player;
  late final videoPlayerController = VideoController(player);

  @override
  void dispose() async {
    super.dispose();
    await player.dispose();
  }

  /// load media file from url
  Future<void> loadVideoFromUrl(VideoOrAudioItem media, {bool play = true}) async {
    if (currentVideo.value?.location == media.location) return;
    currentVideoUrl.value = media.location;
    currentVideo.value = media;
    ControlsController.to.resetVideoProgress();

    VolumeController.to.currentVolume.value = VolumeController.to.currentVolume.value == 0
        ? RpSizes.defaultVolume
        : VolumeController.to.currentVolume.value;

    final windowSize = await RpDeviceUtils.getWindowFrameSize();
    if (windowSize.height == RpSizes.initialAppWindowSize.height &&
        windowSize.width == RpSizes.initialAppWindowSize.width) {
      await RpDeviceUtils.setWindowFrameSize(RpSizes.initialVideoLoadedAppWidowSize);
    }

    /// Add media streams to gather info
    addMediaStreamsForInfo();

    await player.open(Media(media.location));

    if(!SubtitleController.to.isSubtitleEnabled.value){
      await SubtitleController.to.disableSubtitle();
    }

    if (play) {
      await player.play();
    } else {
      await player.pause();
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
}
