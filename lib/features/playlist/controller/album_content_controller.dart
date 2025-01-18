import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playlist/models/playlist_item.dart';

class AlbumContentController extends GetxController {
  static AlbumContentController get to => Get.find();

  final RxList<PlaylistItem> currentContent = <PlaylistItem>[].obs;
  final RxString currentPath = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool canNavigateBack = false.obs;

  // Stack to keep track of navigation history
  final List<String> _navigationStack = [];

  @override
  void onInit() async {
    super.onInit();
    // await AlbumContentController.to.loadDirectory("/home/amalitechpc4100602/disk_d/courses/Complete algorithmic forex trading and back testing system/");
    // print(currentContent);
    print("ssss");
  }

  Future<void> loadDirectory(String dirPath, {navDirection = "down"}) async {
    isLoading.value = false;
    try {
      final directory = Directory(dirPath);
      final List<PlaylistItem> items = [];

      await for (var entity in directory.list()) {
        final name = path.basename(entity.path);
        items.add(
          PlaylistItem(
            name: name,
            location: entity.path,
            isDirectory: entity is Directory,
          ),
        );
      }

      /// Sort: folders first, then files
      items.sort((a, b) {
        if (a.isDirectory && !b.isDirectory) return -1;
        if (!a.isDirectory && b.isDirectory) return 1;
        return a.name.compareTo(b.name);
      });

      if(navDirection == "down"){
        _navigationStack.add(dirPath);
      }

      currentContent.value = items;
      currentPath.value = dirPath;
    } finally{
      isLoading.value = false;
      canNavigateBack.value = canNavigationStackBack();
    }
  }

  void navigateBack(){
    print(_navigationStack.length);
    print(canNavigateBack.value);
    if(_navigationStack.length > 1){
      _navigationStack.removeLast();
      print("*****: ${_navigationStack.length}");
      canNavigateBack.value = canNavigationStackBack();
      print("*****Dw: ${canNavigationStackBack()}");
      loadDirectory(_navigationStack.last, navDirection: "up");
      print("*****D: ${canNavigationStackBack()}");
    }
  }

  bool canNavigationStackBack(){
    return _navigationStack.length > 1;
  }

  bool isMediaFile(String filePath) {
    final videoAndAudioExtensions = [
      // video
      '.mp4', '.avi', '.mkv', '.mov', '.wmv', '.flv', '.webm',
      '.m4v', '.3gp', '.3g2', '.mts', '.ts', '.vob', '.ogv', '.f4v',

      //audio
      '.mp3', '.wav', '.flac', '.aac', '.ogg', '.wma', '.m4a',
      '.aiff', '.alac', '.opus', '.amr', '.pcm', '.mid', '.midi', '.caf'
    ];
    final extension = path.extension(filePath).toLowerCase().trim();
    return videoAndAudioExtensions.contains(extension);
  }

  void handleItemOnTap(PlaylistItem item){
      if (item.isDirectory) {
        loadDirectory(item.location);
      } else if (isMediaFile(item.location)) {
        VideoAndControlController.to.loadVideoFromUrl(item.location);
      }
  }
}
