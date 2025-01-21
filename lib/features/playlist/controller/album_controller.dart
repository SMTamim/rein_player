import 'package:get/get.dart';

import '../models/album.dart';
import 'album_content_controller.dart';

class AlbumController extends GetxController {
  static AlbumController get to => Get.find();

  RxList albums = <Album>[
    Album(name: "Default", location: "adsf", id: "default_album"),
    Album(name: "Playlist 1", location: "/home/amalitechpc4100602/disk_d/courses/Complete algorithmic forex trading and back testing system/"),
  ].obs;

  RxInt selectedAlbumIndex = 1.obs;

  Future<void> updateSelectedAlbumIndex(int index) async {
    if(index == selectedAlbumIndex.value) return;
    AlbumContentController.to.clearNavigationStack();
    selectedAlbumIndex.value = index;
    AlbumContentController.to.currentContent.value = [];
    await AlbumContentController.to.loadDirectory(albums[index].location);
  }
}