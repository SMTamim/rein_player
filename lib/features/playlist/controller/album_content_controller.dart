import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:rein_player/features/playback/controller/controls_controller.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/features/playlist/models/playlist_item.dart';
import 'package:rein_player/utils/constants/rp_extensions.dart';
import 'package:rein_player/utils/extensions/media_extensions.dart';
import 'package:rein_player/utils/helpers/duration_helper.dart';
import 'package:rein_player/utils/helpers/media_helper.dart';

class AlbumContentController extends GetxController {
  static AlbumContentController get to => Get.find();

  final RxList<PlaylistItem> currentContent = <PlaylistItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool canNavigateBack = false.obs;

  final List<String> _navigationStack = [];

  Future<void> loadDirectory(String dirPath, {navDirection = "down"}) async {
    try {
      final List<PlaylistItem> mediaFiles =
          await RpMediaHelper.getMediaFilesInDirectory(dirPath);

      if (navDirection == "down") {
        _navigationStack.add(dirPath);
      }

      currentContent.value = mediaFiles;
    } finally {
      canNavigateBack.value = canNavigationStackBack();
    }
  }

  void addToCurrentPlaylistContent(PlaylistItem item) {
    if (currentContent.any((el) => el.location.trim() == item.location)) return;
    currentContent.add(item);
  }

  void addItemsToPlaylistContent(List<PlaylistItem> items, {clearBefore = false}) {
    if (items.isEmpty) return;
    if(clearBefore) currentContent.clear();
    currentContent.addAll(items);
    sortPlaylistContent();
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

  void addToNavigationStack(String path) {
    if (path.isEmpty) return;
    _navigationStack.add(path);
  }

  void clearNavigationStack() {
    _navigationStack.clear();
  }

  bool isMediaFile(String filePath) {
    final extension = path.extension(filePath).toLowerCase().trim();
    return RpFileExtensions.mediaFileExtensions.contains(extension);
  }

  void handleItemOnTap(PlaylistItem media) async {
    if (media.isDirectory) {
      loadDirectory(media.location);
    } else if (isMediaFile(media.location)) {
      AlbumController.to.updateAlbumCurrentItemToPlay(media.location);
      await AlbumController.to.dumpAllAlbumsToStorage();
      await VideoAndControlController.to
          .loadVideoFromUrl(media.toVideoOrAudioItem());
    }
  }

  //TODO: complete it to show time on watched videos
  void updatePlaylistItemDuration(String url) {
    for (var item in currentContent) {
      if (item.location == url) {
        item.duration.value = RpDurationHelper.formatDuration(ControlsController.to.videoDuration.value);
        break;
      }
    }
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

  int getIndexOfCurrentItemInPlaylist() {
    final currentVideo = VideoAndControlController.to.currentVideo.value;
    if (currentContent.isEmpty || currentVideo == null) return -1;
    return currentContent
        .indexWhere((item) => item.location == currentVideo.location);
  }

  String getPlaylistPlayingProgress() {
    if(AlbumContentController.to.currentContent.length == 1) return "";
    final currentVideoIndex = getIndexOfCurrentItemInPlaylist();
    if (currentVideoIndex == -1) return "";
    return "[${currentVideoIndex + 1}/${currentContent.length}]";
  }

  Future<void> goNextItemInPlaylist() async {
    final currentVideoIndex = getIndexOfCurrentItemInPlaylist();
    if (currentVideoIndex == -1 || currentContent.isEmpty) return;
    if (currentVideoIndex + 1 == currentContent.length) return;
    final media = currentContent[currentVideoIndex + 1];
    await VideoAndControlController.to
        .loadVideoFromUrl(media.toVideoOrAudioItem());
    AlbumController.to.updateAlbumCurrentItemToPlay(media.location);
    await AlbumController.to.dumpAllAlbumsToStorage();
  }

  void goPreviousItemInPlaylist() async {
    final currentVideoIndex = getIndexOfCurrentItemInPlaylist();
    if (currentVideoIndex == -1 ||
        currentContent.isEmpty ||
        currentVideoIndex == 0) return;
    final media = currentContent[currentVideoIndex - 1];
    VideoAndControlController.to
        .loadVideoFromUrl(media.toVideoOrAudioItem());
    AlbumController.to.updateAlbumCurrentItemToPlay(media.location);
    await AlbumController.to.dumpAllAlbumsToStorage();
  }

  void sortPlaylistContent() {
    currentContent.sort(RpMediaHelper.sortMediaFiles);
  }

  Future<void> loadSimilarContentInDefaultAlbum(String filename, String dirPath,
      {excludeCurrentFile = true}) async {
    final List<PlaylistItem> mediaFiles =
        await RpMediaHelper.getMediaFilesInDirectory(dirPath);
    String fileNameWithoutExtension = filename.split('.').first;

    String substringToMatch;
    if (fileNameWithoutExtension.length > 3) {
      int lengthToTake = (fileNameWithoutExtension.length * 0.3).floor();
      substringToMatch =
          fileNameWithoutExtension.substring(3, 3 + lengthToTake);
    } else {
      substringToMatch = fileNameWithoutExtension.substring(0, 1);
    }

    final relatedMedia = mediaFiles.where((file) {
      String otherFileNameWithoutExtension = file.name.split('.').first;
      if (excludeCurrentFile) {
        return otherFileNameWithoutExtension.contains(substringToMatch) &&
            file.name != filename;
      }
      return otherFileNameWithoutExtension.contains(substringToMatch);
    }).toList();
    addItemsToPlaylistContent(relatedMedia);
  }
}
