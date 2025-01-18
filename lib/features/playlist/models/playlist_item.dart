import 'package:rein_player/features/playlist/models/playlist_item_type.dart';

class PlaylistItem {
  PlaylistItem({
    required this.name,
    required this.location,
    required this.isDirectory,
    this.type = PlaylistItemType.VIDEO,
    this.id = "",
    this.currentVideo = "",
  });

  String name, location, id, currentVideo;
  bool isDirectory;
  PlaylistItemType type;


// list of files
// list of folders
}
