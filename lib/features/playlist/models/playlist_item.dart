class PlaylistItem {
  PlaylistItem({
    required this.name,
    required this.location,
    required this.isDirectory,
    this.id = "",
    this.currentVideo = "",
  });

  String name, location, id, currentVideo;
  bool isDirectory;

// list of files
// list of folders
}
