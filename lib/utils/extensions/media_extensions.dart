import 'package:rein_player/features/playback/models/video_audio_item.dart';

import '../../features/playlist/models/playlist_item.dart';

extension PlaylistItemExtension on PlaylistItem {
  VideoOrAudioItem toVideoOrAudioItem() {
    return VideoOrAudioItem(name, location);
  }
}