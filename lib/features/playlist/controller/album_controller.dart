import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:rein_player/utils/constants/rp_keys.dart';
import 'package:rein_player/utils/constants/rp_text.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

import '../models/album.dart';
import 'album_content_controller.dart';

class AlbumController extends GetxController {
  static AlbumController get to => Get.find();

  final storage = RpLocalStorage();

  RxString defaultAlbumLocation = "".obs;
  RxList<Album> albums = <Album>[].obs;

  RxInt selectedAlbumIndex = 0.obs;

  @override
  onInit() async {
    super.onInit();
    Get.put(AlbumContentController());
    loadAllAlbumsFromStorage();
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
      {currentItemToPlay = ""}) async {
    final location = path.dirname(filePath);
    AlbumController.to.defaultAlbumLocation.value = path.dirname(location);
    AlbumController.to.albums.value = await Future.wait(
      AlbumController.to.albums.map(
        (album) async {
          if (album.id == 'default_album') {
            final defaultAlbum = Album(
              name: album.name,
              location: location,
              id: album.id,
            );
            await storage.saveData(
                RpKeysConstants.defaultAlbumLocationKey, defaultAlbum.toJson());
            return album;
          }
          return album;
        },
      ),
    );
  }

  Future<void> dumpAllAlbumsToStorage() async {
    final albumJson = albums
        .where((album) => album.id != RpKeysConstants.defaultAlbumKey)
        .map((album) => album.toJson())
        .toList();
    await storage.saveData(RpKeysConstants.allAlbumsKey, albumJson);
  }

  Future<void> loadAllAlbumsFromStorage() async {
    List<dynamic> albumJson =
        storage.readData(RpKeysConstants.allAlbumsKey) ?? [];
    albums([
      Album(
          name: RpText.defaultAlbumName,
          location: "",
          id: RpKeysConstants.defaultAlbumKey),
      ...albumJson.map((el) => Album.fromJson(el))
    ]);
  }

  Future<void> loadDefaultAlbumPlaylistContent() async {
    final defaultAlbumJson =
        storage.readData(RpKeysConstants.defaultAlbumLocationKey);
    if (defaultAlbumJson == null) return;
    final defaultAlbum = Album.fromJson(defaultAlbumJson);

    AlbumContentController.to.clearNavigationStack();
    AlbumContentController.to.currentContent.value = [];
    await AlbumContentController.to.loadDirectory(defaultAlbum.location);
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
}
