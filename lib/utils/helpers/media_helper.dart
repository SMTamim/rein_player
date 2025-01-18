import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../features/playlist/models/playlist_item_type.dart';
import 'package:path/path.dart' as path;

import '../constants/rp_extensions.dart';

class RpMediaHelper {
  RpMediaHelper._();

  static PlaylistItemType getPlaylistItemType(String filePath) {
    final extension = path.extension(filePath).toLowerCase().trim();
    if (RpFileExtensions.videoExtensions.contains(extension)) {
      return PlaylistItemType.VIDEO;
    }

    if (RpFileExtensions.audioExtensions.contains(extension)) {
      return PlaylistItemType.AUDIO;
    }

    if (RpFileExtensions.subtitleExtensions.contains(extension)) {
      return PlaylistItemType.SUBTITLE;
    }

    if (FileSystemEntity.typeSync(filePath) == FileSystemEntityType.directory) {
      return PlaylistItemType.DIRECTORY;
    }

    return PlaylistItemType.UNSUPPORTED;
  }

  static bool isPlaylistItemSupported(String path) =>
      getPlaylistItemType(path) != PlaylistItemType.UNSUPPORTED;

  static bool isPlaylistItemSupportedAndNotSubtitle(String path){
    final type = getPlaylistItemType(path);
    return  type != PlaylistItemType.UNSUPPORTED && type != PlaylistItemType.SUBTITLE;
  }


  static bool isMediaFile(String filePath) {
    final allTypes = [...RpFileExtensions.audioExtensions, ...RpFileExtensions.videoExtensions];
    final extension = path.extension(filePath).toLowerCase().trim();
    return allTypes.contains(extension);
  }
}
