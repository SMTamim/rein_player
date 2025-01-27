import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playback/models/video_audio_item.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';
import 'package:rein_player/utils/constants/rp_text.dart';
import 'package:rein_player/utils/helpers/media_helper.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

import '../models/album.dart';
import 'album_content_controller.dart';

class AlbumController extends GetxController {
  static AlbumController get to => Get.find();

  final storage = RpLocalStorage();

  RxList<Album> albums = <Album>[].obs;

  RxInt selectedAlbumIndex = 0.obs;

  @override
  onInit() async {
    super.onInit();
    Get.put(AlbumContentController());
    await loadAllAlbumsFromStorage();
    await loadDefaultAlbumPlaylistContent();
  }

  Future<void> updateSelectedAlbumIndex(int index) async {
    if (index == selectedAlbumIndex.value) return;
    AlbumContentController.to.clearNavigationStack();
    selectedAlbumIndex.value = index;
    AlbumContentController.to.currentContent.value = [];
    await AlbumContentController.to.loadDirectory(albums[index].location);
  }

  Future<void> setDefaultAlbum(String filePath,
      {String currentItemToPlay = ""}) async {
    final location = path.dirname(filePath);
    AlbumController.to.albums.value = AlbumController.to.albums.map(
      (album) {
        if (album.id == 'default_album') {
          return Album(
              name: album.name,
              location: location,
              id: album.id,
              currentItemToPlay: currentItemToPlay.isEmpty
                  ? album.currentItemToPlay
                  : currentItemToPlay);
        }
        return album;
      },
    ).toList();
   await dumpAllAlbumsToStorage();
  }

  Future<void> dumpAllAlbumsToStorage() async {
    final albumJson = albums.map((album) => album.toJson()).toList();
    await storage.saveData(RpKeysConstants.allAlbumsKey, albumJson);
  }

  Future<void> loadAllAlbumsFromStorage() async {
    List<dynamic> albumJson =
        storage.readData(RpKeysConstants.allAlbumsKey) ?? [];
    final loadedAlbums = albumJson.map((el) => Album.fromJson(el)).toList();

    albums([
      if (!(loadedAlbums
          .any((item) => item.id == RpKeysConstants.defaultAlbumKey)))
        Album(
          name: RpText.defaultAlbumName,
          location: "",
          id: RpKeysConstants.defaultAlbumKey,
        ),
      ...loadedAlbums
    ]);
  }

  Future<void> loadDefaultAlbumPlaylistContent() async {
    final defaultAlbum = albums.where((album) => album.id == RpKeysConstants.defaultAlbumKey).firstOrNull;
    if(defaultAlbum == null) return;

    AlbumContentController.to.clearNavigationStack();
    AlbumContentController.to.currentContent.value = [];
    final mediaInDirectory =
        await RpMediaHelper.getMediaFilesInDirectory(defaultAlbum.location);
    final currentItemToPlay = mediaInDirectory
        .firstWhereOrNull((media) => media.location == defaultAlbum.currentItemToPlay);
    if (currentItemToPlay != null) {
      await VideoAndControlController.to.loadVideoFromUrl(VideoOrAudioItem(currentItemToPlay.name, currentItemToPlay.location));
      await AlbumContentController.to.loadSimilarContentInDefaultAlbum(
          path.basename(defaultAlbum.currentItemToPlay), defaultAlbum.location,
          excludeCurrentFile: false);
    } else {
      await AlbumContentController.to.loadDirectory(defaultAlbum.location);
    }
  }

  void removeAlbumFromList(Album album) async {
    final filteredAlbums = albums
        .where((album) =>
            album.id == RpKeysConstants.defaultAlbumKey ||
            album.location != album.location)
        .toList();

    albums(filteredAlbums);
    await storage.removeData(RpKeysConstants.allAlbumsKey);
    final _ = await dumpAllAlbumsToStorage();
  }

  void updateAlbumCurrentItemToPlay(String currentMediaUrl) {
    final currentAlbum = albums[selectedAlbumIndex.value];
    currentAlbum.currentItemToPlay = currentMediaUrl;

    albums.value = albums.map((album) {
      if (album.location == currentAlbum.location) {
        album.currentItemToPlay = currentMediaUrl;
        return album;
      }
      return album;
    }).toList();
  }
}
