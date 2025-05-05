import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/features/playlist/models/album.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';
import 'package:window_manager/window_manager.dart';

import '../views/add_playlist_modal.dart';

class PlaylistController extends GetxController {
  static PlaylistController get to => Get.find();

  final storage = RpLocalStorage();

  final isPlaylistWindowOpened = false.obs;
  Rx<double> playlistWindowWidth = RpSizes.minPlaylistWindowSize.obs;

  /// add playlist
  final playlistNameController = TextEditingController();
  final RxString selectedFolderPath = "".obs;
  final FocusNode playlistNameFocusNode = FocusNode();

  void togglePlaylistWindow() async {
    final currentSize = await windowManager.getSize();
    if (isPlaylistWindowOpened.value) {
      windowManager.setSize(Size(
          currentSize.width - playlistWindowWidth.value, currentSize.height));
    } else {
      windowManager.setSize(Size(
          currentSize.width + playlistWindowWidth.value, currentSize.height));
    }
    isPlaylistWindowOpened.value = !isPlaylistWindowOpened.value;
  }

  void updatePlaylistWindowSizeOnDrag(DragUpdateDetails details) {
    final dx = details.delta.dx;
    final videoAndControlScreenSize =
        VideoAndControlController.to.videoAndControlScreenSize.value;

    if (dx > 0 && playlistWindowWidth.value > RpSizes.minPlaylistWindowSize) {
      playlistWindowWidth.value -= dx;
    } else if (dx < 0 &&
        videoAndControlScreenSize > RpSizes.minWindowAndControlScreenSize) {
      playlistWindowWidth.value -= dx;
    }
  }

  Future<void> showAddPlaylistModal() {
    return Get.dialog(const RpAddPlaylistModal(), barrierDismissible: false);
  }

  Future<void> pickFolder() async {
    String? folderPath = await FilePicker.platform.getDirectoryPath();
    selectedFolderPath.value = folderPath ?? "";
    }

  void createNewPlaylist() async {
    if (playlistNameController.text.trim().isEmpty ||
        selectedFolderPath.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields',
          snackPosition: SnackPosition.TOP, maxWidth: 500);
      return;
    }

    if(AlbumController.to.albums.any((album) => album.location == selectedFolderPath.value)){
      Get.snackbar('Error', 'Album already added',
          snackPosition: SnackPosition.TOP, maxWidth: 500);
      return;
    }

    AlbumController.to.albums.add(
      Album(
        name: playlistNameController.value.text.trim(),
        location: selectedFolderPath.value,
      ),
    );
    /// dump list to local storage
    AlbumController.to.dumpAllAlbumsToStorage();
    await AlbumController.to.updateSelectedAlbumIndex(AlbumController.to.albums.length - 1);
    clearForm();
    Get.back();
  }

  void clearForm() {
    playlistNameController.clear();
    selectedFolderPath.value = '';
  }

  @override
  void onClose() {
    playlistNameController.dispose();
    playlistNameFocusNode.dispose();
    super.onClose();
  }
}
