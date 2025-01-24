import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:rein_player/utils/constants/rp_storage.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

import '../models/album.dart';
import 'album_content_controller.dart';

class AlbumController extends GetxController {
  static AlbumController get to => Get.find();

  final storage = RpLocalStorage();

  @override
  onInit() async {
    super.onInit();
    Get.put(AlbumContentController());
    String? defaultAlbumLocation =
        storage.readData(RpStorageConstants.defaultAlbumLocationKey);
    if (defaultAlbumLocation == null || defaultAlbumLocation.isEmpty) return;
    AlbumContentController.to.clearNavigationStack();
    AlbumContentController.to.currentContent.value = [];
    await AlbumContentController.to.loadDirectory(defaultAlbumLocation);
  }

  RxString defaultAlbumLocation = "".obs;

  RxList albums = <Album>[
    Album(name: "Default", location: "", id: "default_album"),
    Album(
        name: "Playlist 1",
        location:
            "/home/amalitechpc4100602/disk_d/courses/Complete algorithmic forex trading and back testing system/"),
  ].obs;

  RxInt selectedAlbumIndex = 0.obs;

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
    await storage.saveData(
        RpStorageConstants.defaultAlbumLocationKey, location);
  }
}
