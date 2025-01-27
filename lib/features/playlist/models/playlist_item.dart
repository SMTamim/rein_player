import 'package:get/get.dart';
import 'package:rein_player/features/playlist/models/playlist_item_type.dart';

class PlaylistItem {
  PlaylistItem({
    required this.name,
    required this.location,
    required this.isDirectory,
    this.type = PlaylistItemType.VIDEO,
    this.id = "",
    this.currentVideo = "",
    String duration = ""
  }): duration = RxString(duration);

  String name, location, id, currentVideo;
  RxString duration;
  bool isDirectory;
  PlaylistItemType type;

}
