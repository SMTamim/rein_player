import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:media_kit/media_kit.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/audio_track_controller.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';
import 'package:rein_player/features/playback/controller/playlist_type_controller.dart';
import 'package:rein_player/features/playback/controller/subtitle_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';
import 'package:rein_player/features/settings/views/keyboard_bindings_modal.dart';
import 'package:rein_player/utils/constants/rp_enums.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

List<RpMenuItem> get defaultMenuData {
  final currentType = PlaylistTypeController.to.playlistType.value;
  final availableAudioTracks = AudioTrackController.to.availableAudioTracks;
  final currentAudioTrack = AudioTrackController.to.currentAudioTrack.value;

  return [
    /// Open file
    RpMenuItem(
      text: "Open File",
      icon: Icons.file_open,
      onTap: ControlsController.to.open,
    ),

    /// Subtitles
    RpMenuItem(
      text: "Subtitles",
      icon: Icons.subtitles,
      subMenuItems: [
        RpMenuItem(
          icon: Icons.add,
          text: "Add Subtitle",
          onTap: SubtitleController.to.loadSubtitle,
        ),
        RpMenuItem(
          icon: Icons.remove,
          text: "Disable Subtitle",
          onTap: SubtitleController.to.disableSubtitle,
        ),
      ],
    ),

    /// Audio
    RpMenuItem(
      text: "Audio",
      icon: Icons.audiotrack,
      subMenuItems:
          _buildAudioTrackMenu(availableAudioTracks, currentAudioTrack),
    ),

    // Preferences submenu
    RpMenuItem(
      text: "Preferences",
      icon: Icons.settings,
      subMenuItems: [
        RpMenuItem(
          icon: Icons.keyboard,
          text: "Keyboard Bindings",
          onTap: () {
            Get.dialog(const KeyboardBindingsModal());
          },
        ),
      ],
    ),

    /// Playlist Type
    RpMenuItem(
      text: "Playlist Type",
      icon: Icons.featured_play_list,
      subMenuItems: [
        RpMenuItem(
          icon: currentType == PlaylistType.defaultPlaylistType
              ? Icons.check
              : null,
          text: "Default",
          onTap: () => PlaylistTypeController.to
              .changePlaylistType(PlaylistType.defaultPlaylistType),
        ),
        RpMenuItem(
          icon: currentType == PlaylistType.potPlayerPlaylistType
              ? Icons.check
              : null,
          text: "Pot Player",
          onTap: () => PlaylistTypeController.to
              .changePlaylistType(PlaylistType.potPlayerPlaylistType),
        ),
      ],
    ),

    /// Exit
    RpMenuItem(
      text: "Exit",
      icon: Icons.exit_to_app,
      onTap: () {
        WindowActionsController.to.closeWindow();
      },
    ),
  ];
}

List<RpMenuItem> _buildAudioTrackMenu(
    List<AudioTrack> availableAudioTracks, AudioTrack? currentAudioTrack) {
  List<RpMenuItem> audioMenuItems = [];

  print(
      'DEBUG: Building audio menu - Current track ID: ${currentAudioTrack?.id}');
  print('DEBUG: Available tracks count: ${availableAudioTracks.length}');

  // Add "Track auto" option
  final isAutoSelected = currentAudioTrack?.id == 'auto' ||
      (currentAudioTrack == null && availableAudioTracks.isNotEmpty);

  audioMenuItems.add(
    RpMenuItem(
      icon: isAutoSelected ? Icons.check : null,
      text: "Track auto",
      onTap: () async {
        try {
          await AudioTrackController.to.player.setAudioTrack(AudioTrack.auto());
          print('DEBUG: Selected audio track: auto');
        } catch (e) {
          print('ERROR: Failed to set auto audio track: $e');
        }
      },
    ),
  );

  // Add "Track no" option (disable audio)
  final isNoSelected = currentAudioTrack?.id == 'no';

  audioMenuItems.add(
    RpMenuItem(
      icon: isNoSelected ? Icons.check : null,
      text: "Track no",
      onTap: () async {
        try {
          await AudioTrackController.to.player.setAudioTrack(AudioTrack.no());
          print('DEBUG: Selected audio track: no');
        } catch (e) {
          print('ERROR: Failed to set no audio track: $e');
        }
      },
    ),
  );

  // Add separator if there are actual tracks
  if (availableAudioTracks.isNotEmpty) {
    audioMenuItems.add(
      RpMenuItem(
        icon: null,
        text: "─────────────", // Visual separator
        enabled: false,
        onTap: () {},
      ),
    );
  }

  // Add all available audio tracks
  for (int i = 0; i < availableAudioTracks.length; i++) {
    final track = availableAudioTracks[i];
    final isSelected = currentAudioTrack?.id == track.id;
    final displayName = AudioTrackController.to.getAudioTrackDisplayName(track);

    print(
        'DEBUG: Adding track ${i + 1}: ${displayName} (ID: ${track.id}) - Selected: $isSelected');

    audioMenuItems.add(
      RpMenuItem(
        icon: isSelected ? Icons.check : null,
        text: displayName,
        onTap: () async {
          try {
            await AudioTrackController.to.selectAudioTrack(track);
            print('DEBUG: User selected audio track: ${displayName}');
          } catch (e) {
            print('ERROR: Failed to select audio track: $e');
          }
        },
      ),
    );
  }

  // If no tracks are available, show a message
  if (availableAudioTracks.isEmpty) {
    audioMenuItems.add(
      RpMenuItem(
        icon: null,
        text: "No additional tracks available",
        enabled: false,
        onTap: () {},
      ),
    );
  }

  print('DEBUG: Built audio menu with ${audioMenuItems.length} total items');
  print(
      'DEBUG: Menu items: ${audioMenuItems.map((item) => item.text).join(", ")}');

  return audioMenuItems;
}

ContextMenu createContextMenu() {
  return ContextMenu(
    entries: convertToContextMenuEntries(defaultMenuData),
    boxDecoration: const BoxDecoration(
      color: RpColors.gray_800,
      borderRadius: BorderRadius.zero,
    ),
    padding: EdgeInsets.zero,
  );
}

List<ContextMenuEntry> convertToContextMenuEntries(List<RpMenuItem> items) {
  return items.map((item) {
    if (item.hasSubMenu) {
      return MenuItem.submenu(
        label: item.text,
        icon: item.icon,
        items: convertToContextMenuEntries(item.subMenuItems!),
      );
    } else {
      return MenuItem(
        label: item.text,
        icon: item.icon,
        enabled: item.enabled,
        value: item.text,
        onSelected: item.onTap ?? () {},
      );
    }
  }).toList();
}
