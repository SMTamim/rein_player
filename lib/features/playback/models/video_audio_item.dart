class VideoOrAudioItem {
  VideoOrAudioItem(this.name, this.location, this.extension, {this.size = 0});

  final String name;
  final String location;
  final String extension;
  int size;
}
