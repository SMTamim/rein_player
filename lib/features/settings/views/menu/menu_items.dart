import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:rein_player/features/playback/controller/audio_track_controller.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';
import 'package:rein_player/features/playback/controller/playlist_type_controller.dart';
import 'package:rein_player/features/playback/controller/subtitle_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';
import 'package:rein_player/utils/constants/rp_enums.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

List<RpMenuItem> get defaultMenuData {
  final currentType = PlaylistTypeController.to.playlistType.value;
  final availableAudioTracks = AudioTrackController.to.availableAudioTracks;
  final currentAudioTrack = AudioTrackController.to.currentAudioTrack.value;

  return [
    RpMenuItem(
      text: "Open File",
      icon: Icons.file_open,
      onTap: ControlsController.to.open,
    ),
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
    // Audio submenu - only show if there are multiple audio tracks
    if (availableAudioTracks.length > 1)
      RpMenuItem(
        text: "Audio",
        icon: Icons.audiotrack,
        subMenuItems: availableAudioTracks.map((track) {
          print('track: ${track.id} ${track.title} ${track.language}');
          final isSelected = currentAudioTrack?.id == track.id;
          return RpMenuItem(
            icon: isSelected ? Icons.check : null,
            text: AudioTrackController.to.getAudioTrackDisplayName(track),
            onTap: () => AudioTrackController.to.selectAudioTrack(track),
          );
        }).toList(),
      ),
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
    RpMenuItem(
      text: "Exit",
      icon: Icons.exit_to_app,
      onTap: () {
        WindowActionsController.to.closeWindow();
      },
    ),
  ];
}

// Create a reactive ContextMenu that updates when data changes
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

// Backward compatibility - this will get current menu at the time it's called
List<ContextMenuEntry> get contextMenuItems {
  return convertToContextMenuEntries(defaultMenuData);
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
