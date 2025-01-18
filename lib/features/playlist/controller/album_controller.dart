import 'package:get/get.dart';

import '../models/album.dart';
import 'album_content_controller.dart';

class AlbumController extends GetxController {
  static AlbumController get to => Get.find();

  RxList albums = <Album>[
    Album(name: "Default", location: "adsf"),
    Album(name: "Playlist 1", location: "/home/amalitechpc4100602/disk_d/courses/Complete algorithmic forex trading and back testing system/"),
    Album(name: "Playlist 2", location: "loca1"),
  ].obs;

  RxInt selectedAlbumIndex = 1.obs;

  void updateSelectedAlbumIndex(int index) async {
    selectedAlbumIndex.value = index;
    AlbumContentController.to.currentContent.value = [];
    await AlbumContentController.to.loadDirectory("/home/amalitechpc4100602/disk_d/courses/Complete algorithmic forex trading and back testing system/");
    print(AlbumContentController.to.currentContent);
  }
}