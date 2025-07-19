import 'package:rein_player/utils/constants/rp_enums.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';

class Settings {
  bool isSubtitleEnabled;
  PlaylistType playlistType;

  Settings(
      {this.isSubtitleEnabled = true,
      this.playlistType = PlaylistType.defaultPlaylistType});

  factory Settings.fromJson(Map<String, dynamic> json) {
    PlaylistType savedPlaylistType = PlaylistType.values.byName(
        json[RpKeysConstants.playlistTypeStorageKey] ??
            PlaylistType.defaultPlaylistType.name);

    return Settings(
      isSubtitleEnabled:
          json[RpKeysConstants.subtitleEnabledStorageKey] as bool? ?? false,
      playlistType: savedPlaylistType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      RpKeysConstants.subtitleEnabledStorageKey: isSubtitleEnabled,
      RpKeysConstants.playlistTypeStorageKey: playlistType.name,
    };
  }

  Map<String, dynamic> defaultSettings() {
    return toJson();
  }
}
