import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/playlist/controller/album_content_controller.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';
import 'package:rein_player/utils/extensions/media_extensions.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';
import 'package:window_manager/window_manager.dart';
import 'package:rein_player/utils/helpers/media_helper.dart';
import 'package:rein_player/features/playlist/models/playlist_item.dart';

class WindowController extends GetxController with WindowListener {
  static WindowController get to => Get.find();

  final storage = RpLocalStorage();

  Rx<Size> currentWindowSize = Size.zero.obs;
  RxBool isWindowLoaded = false.obs;
  RxBool isDraggingOnWindow = false.obs;

  @override
  void onInit() {
    windowManager.addListener(this);
    super.onInit();
  }

  Future<void> onWindowDrop(List<DropItem> files) async {
    final List<PlaylistItem> mediaFiles = [];

    for (var file in files) {
      if (!RpMediaHelper.isPlaylistItemSupportedAndNotSubtitle(file.path)) {
        continue;
      }

      mediaFiles.add(PlaylistItem(
        name: file.name,
        location: file.path,
        isDirectory: await FileSystemEntity.isDirectory(file.path),
        type: RpMediaHelper.getPlaylistItemType(file.path),
      ));
    }
    
    AlbumContentController.to.addItemsToPlaylistContent(mediaFiles, clearBefore: true);

    /// load the first video
    final firstVideo = mediaFiles.firstWhereOrNull((media) => !media.isDirectory);
    final directory = mediaFiles.firstWhereOrNull((media) => media.isDirectory);
    if(firstVideo != null){
      await VideoAndControlController.to.loadVideoFromUrl(firstVideo.toVideoOrAudioItem());
      await AlbumController.to.setDefaultAlbum(firstVideo.location, currentItemToPlay: firstVideo.location);
      WindowActionsController.to.maximizeWindow();
    }else if(directory != null){
      await AlbumController.to.setDefaultAlbum(directory.location, makeDirectoryPath: false);
      await AlbumContentController.to.loadDirectory(directory.location);
    }
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();
    currentWindowSize.value = await windowManager.getSize();

    /// boolean to load the window before rendering the video
    final sizeToCompareWith = AlbumController.to.isMediaInDefaultAlbumLocation()
        ? RpSizes.initialVideoLoadedAppWidowSize
        : RpSizes.initialAppWindowSize;
    isWindowLoaded.value = currentWindowSize.value.width >= sizeToCompareWith.width;
  }
}
