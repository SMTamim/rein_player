import 'package:media_kit/media_kit.dart';

class VideoPlayer {
  VideoPlayer._internal();

  late final Player player;

  static final VideoPlayer _instance =  VideoPlayer._internal();

  static VideoPlayer get getInstance => _instance;

  void ensureInitialized(){
    player = Player();
  }

  void dispose(){
    player.dispose();
  }
}