import 'package:media_kit/media_kit.dart';

class VideoPlayer {
  static final VideoPlayer _instance = VideoPlayer._internal();
  static VideoPlayer get getInstance => _instance;
  
  Player? _player;
  
  VideoPlayer._internal();

  Future<void> ensureInitialized() async {
    await _player?.dispose();
    _player = null;
    _player = Player();
  }

  Player get player {
    if (_player == null) {
      throw Exception('VideoPlayer not initialized');
    }
    return _player!;
  }

  Future<void> dispose() async {
    await _player?.dispose();
    _player = null;
  }
}