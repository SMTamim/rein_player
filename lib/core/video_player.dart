import 'package:flutter/foundation.dart';
import 'package:media_kit/media_kit.dart';

class VideoPlayer {
  static final VideoPlayer _instance = VideoPlayer._internal();
  static VideoPlayer get getInstance => _instance;

  Player? _player;

  VideoPlayer._internal();

  Future<void> ensureInitialized() async {
    try {
      await _player?.dispose();
      _player = null;
      _player = Player();

      if (_player!.platform is NativePlayer) {
        try {
          // Basic player properties
          await (_player!.platform as dynamic).setProperty(
            'force-seekable',
            'yes',
          );

          // Disable hardware video decoding (most important)
          await (_player!.platform as dynamic).setProperty(
            'hwdec',
            'no',
          );

          // Use software video output instead of GPU
          await (_player!.platform as dynamic).setProperty(
            'vo',
            'libmpv',
          );

          // Disable all hardware decode codecs
          await (_player!.platform as dynamic).setProperty(
            'hwdec-codecs',
            'no',
          );

          // Force software fallback for video decoding
          await (_player!.platform as dynamic).setProperty(
            'vd-lavc-software-fallback',
            'yes',
          );

          // Disable OpenGL/GPU contexts that might use CUDA
          await (_player!.platform as dynamic).setProperty(
            'gpu-api',
            'no',
          );

          // Additional safety options for stability
          await (_player!.platform as dynamic).setProperty(
            'vo-null-fallback',
            'yes',
          );

          await (_player!.platform as dynamic).setProperty(
            'ao-null-fallback',
            'yes',
          );
        } catch (e) {
          try {
            await (_player!.platform as dynamic)
                .setProperty('force-seekable', 'yes');
            await (_player!.platform as dynamic).setProperty('hwdec', 'no');

          } catch (fallbackError) {
            if (kDebugMode) {
              print('Failed to apply basic settings: $fallbackError');
            }
          }
        }
      }
    } catch (e) {
      try {
        _player = Player();
      } catch (fallbackError) {
        if (kDebugMode) {
          print('Failed to create fallback player: $fallbackError');
        }
        throw Exception('VideoPlayer initialization failed completely');
      }
    }
  }

  Player get player {
    if (_player == null) {
      throw Exception('VideoPlayer not initialized');
    }
    return _player!;
  }

  Future<void> dispose() async {
    try {
      await _player?.dispose();
      _player = null;
    } catch (e) {
      if (kDebugMode) {
        print('Error disposing video player: $e');
      }
      _player = null;
    }
  }
}
