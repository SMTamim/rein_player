import 'package:path/path.dart' as path;

class VideoOrAudioItem {
  VideoOrAudioItem(this.name, this.location, {this.size = 0}): extension = path.extension(location);

  final String name;
  final String location;
  final String extension;
  int size;
}
