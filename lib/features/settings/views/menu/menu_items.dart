import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';
import 'package:rein_player/features/playback/controller/playlist_type_controller.dart';
import 'package:rein_player/features/playback/controller/subtitle_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';
import 'package:rein_player/utils/constants/rp_enums.dart';

List<RpMenuItem> get defaultMenuData {
  final currentType = PlaylistTypeController.to.playlistType.value;

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
