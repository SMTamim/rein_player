import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';
import 'package:rein_player/features/playback/controller/playback_speed_controller.dart';
import 'package:rein_player/features/playback/controller/subtitle_controller.dart';
import 'package:rein_player/features/playback/controller/volume_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/playlist/controller/album_content_controller.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/features/developer/controller/developer_log_controller.dart';

class KeyboardController extends GetxController {
  static KeyboardController get to => Get.find();

  void handleKey(KeyEvent event) async {
    if (event is KeyDownEvent) {
      final isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
      final isCtrlPressed = HardwareKeyboard.instance.isControlPressed;

      switch (event.logicalKey) {
        /// pause or play
        case LogicalKeyboardKey.space:
          ControlsController.to.pauseOrPlay();
          break;

        /// full screen
        case LogicalKeyboardKey.enter:
          if (!WindowActionsController.to.isFullScreenMode.value) {
            WindowActionsController.to.toggleWindowSize();
          }
          break;

        /// go back
        case LogicalKeyboardKey.arrowLeft:
          {
            if (isShiftPressed) {
              await ControlsController.to.bigSeekBackward();
            } else {
              await ControlsController.to.seekBackward();
            }
            break;
          }

        /// go forward
        case LogicalKeyboardKey.arrowRight:
          {
            if (isShiftPressed) {
              await ControlsController.to.bigSeekForward();
            } else {
              await ControlsController.to.seekForward();
            }
            break;
          }

        /// increase volume
        case LogicalKeyboardKey.arrowUp:
          {
            final currentVolume = VolumeController.to.currentVolume.value;
            final volumeToSet = currentVolume + 0.1;
            if (volumeToSet > 1) {
              VolumeController.to.updateVolume(1);
            } else {
              VolumeController.to.updateVolume(volumeToSet);
            }
            break;
          }

        /// volume down
        case LogicalKeyboardKey.arrowDown:
          {
            final currentVolume = VolumeController.to.currentVolume.value;
            final volumeToSet = currentVolume - 0.1;
            if (volumeToSet < 0) {
              VolumeController.to.updateVolume(0);
            } else {
              VolumeController.to.updateVolume(volumeToSet);
            }
            break;
          }
        case LogicalKeyboardKey.keyM:
          VolumeController.to.toggleVolumeMuteState();
          break;
        case LogicalKeyboardKey.keyH:
          SubtitleController.to.toggleSubtitle();
          break;

        /// full screen and playlist
        case LogicalKeyboardKey.escape:
          WindowActionsController.to.toggleFullScreenWindow();
          break;
        case LogicalKeyboardKey.keyB:
          if (isCtrlPressed) {
            PlaylistController.to.togglePlaylistWindow();
          }
          break;

        /// Developer log
        case LogicalKeyboardKey.keyD:
          if (isCtrlPressed) {
            DeveloperLogController.to.toggleVisibility();
          }
          break;

        // Playback speed controls
        case LogicalKeyboardKey.keyX:
          PlaybackSpeedController.to.decreaseSpeed();
          break;
        case LogicalKeyboardKey.keyC:
          PlaybackSpeedController.to.increaseSpeed();
          break;

        case LogicalKeyboardKey.pageDown:
          await AlbumContentController.to.goNextItemInPlaylist();
          break;
        case LogicalKeyboardKey.pageUp:
          AlbumContentController.to.goPreviousItemInPlaylist();
          break;
      }
    }
  }
}
