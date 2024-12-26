import 'package:get/get.dart';

class PlaylistController extends GetxController {
  final isPlaylistWindowOpened = false.obs;

  void togglePlaylistWindow() =>
      isPlaylistWindowOpened.value = !isPlaylistWindowOpened.value;


}
