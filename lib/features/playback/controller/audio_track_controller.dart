import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';

class AudioTrackController extends GetxController {
  static AudioTrackController get to => Get.find();

  final player = VideoAndControlController.to.videoPlayerController.player;

  final RxList<AudioTrack> availableAudioTracks = <AudioTrack>[].obs;

  final Rx<AudioTrack?> currentAudioTrack = Rx<AudioTrack?>(null);

  @override
  void onInit() {
    super.onInit();
    _setupAudioTrackListener();
  }

  void _setupAudioTrackListener() {
    player.stream.tracks.listen((tracks) {
      availableAudioTracks.value = tracks.audio;

      if (tracks.audio.isNotEmpty && currentAudioTrack.value == null) {
        currentAudioTrack.value = tracks.audio.first;
      }
    });

    player.stream.track.listen((track) {
      currentAudioTrack.value = track.audio;
    });
  }

  /// Switch to a specific audio track
  Future<void> selectAudioTrack(AudioTrack track) async {
    try {
      await player.setAudioTrack(track);
      currentAudioTrack.value = track;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to switch audio track: $e',
        snackPosition: SnackPosition.TOP,
        maxWidth: 500,
      );
    }
  }

  String getAudioTrackDisplayName(AudioTrack track) {
    final parts = <String>[];

    if (track.title?.isNotEmpty == true) {
      parts.add(track.title!);
    }

    if (track.language?.isNotEmpty == true) {
      parts.add(track.language!);
    }

    // Add track ID as fallback
    parts.add('Track ${track.id}');

    return parts.join(' - ');
  }

  /// Check if an audio track is currently selected
  bool isTrackSelected(AudioTrack track) {
    return currentAudioTrack.value?.id == track.id;
  }

  /// Reset audio tracks when video changes
  void resetAudioTracks() {
    availableAudioTracks.clear();
    currentAudioTrack.value = null;
  }
}
