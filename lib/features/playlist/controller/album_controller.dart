import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:rein_player/utils/constants/rp_keys.dart';
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

  Future<void> setDefaultAlbumLocation(String filePath) async {
    final location = path.dirname(filePath);
    AlbumController.to.defaultAlbumLocation.value = path.dirname(location);
    AlbumController.to.albums.value = AlbumController.to.albums.map((album) {
      if (album.id == 'default_album') {
        return Album(
          name: album.name,
          location: location,
          id: album.id,
        );
      }
      return album;
    }).toList();
    await storage.saveData(RpKeysConstants.defaultAlbumLocationKey, location);
  }

  void dumpAllAlbumsToStorage() async {
    final albumJson = albums
        .where((album) => album.id != RpKeysConstants.defaultAlbumKey)
        .map((album) => album.toJson())
        .toList();
    await storage.saveData(RpKeysConstants.allAlbumsKey, albumJson);
  }

  void loadAllAlbumsFromStorage() async {
    List<dynamic> albumJson =
        storage.readData(RpKeysConstants.allAlbumsKey) ?? [];
    albums([
      Album(name: "Default", location: "", id: "default_album"),
      ...albumJson.map((el) => Album.fromJson(el))
    ]);
  }

  Future<void> loadDefaultAlbumPlaylistContent() async {
    String? defaultAlbumLocation =
        storage.readData(RpKeysConstants.defaultAlbumLocationKey);
    if (defaultAlbumLocation == null || defaultAlbumLocation.isEmpty) {
      return;
    }
    AlbumContentController.to.clearNavigationStack();
    AlbumContentController.to.currentContent.value = [];
    await AlbumContentController.to.loadDirectory(defaultAlbumLocation);
  }
}
