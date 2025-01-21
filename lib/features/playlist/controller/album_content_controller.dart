import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/features/playlist/models/playlist_item.dart';
import 'package:rein_player/utils/constants/rp_extensions.dart';
import 'package:rein_player/utils/helpers/media_helper.dart';

class AlbumContentController extends GetxController {
  static AlbumContentController get to => Get.find();

  final RxList<PlaylistItem> currentContent = <PlaylistItem>[].obs;
  final RxString currentPath = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool canNavigateBack = false.obs;

  // Stack to keep track of navigation history
  final List<String> _navigationStack = [];

  Future<void> loadDirectory(String dirPath, {navDirection = "down"}) async {
    try {
      isLoading.value = false;
      final directory = Directory(dirPath);
      final List<PlaylistItem> mediaFiles = [];

      await for (var entity in directory.list()) {
        final name = path.basename(entity.path);
        if (!RpMediaHelper.isPlaylistItemSupportedAndNotSubtitle(entity.path)) {
          continue;
        }

        mediaFiles.add(PlaylistItem(
          name: name,
          location: entity.path,
          isDirectory: entity is Directory,
          type: RpMediaHelper.getPlaylistItemType(entity.path),
        ));
      }

      /// Sort: folders first, then files
      mediaFiles.sort(_sortMediaFiles);

      if (navDirection == "down") {
        _navigationStack.add(dirPath);
      }

      currentContent.value = mediaFiles;
      currentPath.value = dirPath;
    } finally {
      isLoading.value = false;
      canNavigateBack.value = canNavigationStackBack();
    }
  }

  void navigateBack() {
    if (_navigationStack.length > 1) {
      _navigationStack.removeLast();
      canNavigateBack.value = canNavigationStackBack();
      loadDirectory(_navigationStack.last, navDirection: "up");
    }
  }

  bool canNavigationStackBack() {
    return _navigationStack.length > 1;
  }

  bool isMediaFile(String filePath) {
    final extension = path.extension(filePath).toLowerCase().trim();
    return RpFileExtensions.mediaFileExtensions.contains(extension);
  }

  void handleItemOnTap(PlaylistItem item) {
    if (item.isDirectory) {
      loadDirectory(item.location);
    } else if (isMediaFile(item.location)) {
      VideoAndControlController.to.loadVideoFromUrl(item.location);
    }
  }

  int _sortMediaFiles(a, b){
    if (a.isDirectory != b.isDirectory) {
      return a.isDirectory ? -1 : 1;
    }

    RegExp numberPrefix = RegExp(r'^(\d+)\.\s*(.*)');
    var matchA = numberPrefix.firstMatch(a.name);
    var matchB = numberPrefix.firstMatch(b.name);

    if (matchA != null && matchB != null) {
      int numberA = int.parse(matchA.group(1)!);
      int numberB = int.parse(matchB.group(1)!);
      if (numberA != numberB) {
        return numberA.compareTo(numberB);
      }
      return matchA.group(2)!.compareTo(matchB.group(2)!);
    }

    if (matchA != null) return -1;
    if (matchB != null) return 1;

    return a.name.compareTo(b.name);
  }

  String adjustTitleOnPlaylistSidebarSize(String title) {
    final sidebarWidth = PlaylistController.to.playlistWindowWidth.value;
    final adjustedWidth = (sidebarWidth * 1).round();
    const averageCharWidth = 8;
    final maxChars = (adjustedWidth / averageCharWidth).floor();
    if (title.length > maxChars) {
      return '${title.substring(0, maxChars)}...';
    }
    return title;
  }
}
