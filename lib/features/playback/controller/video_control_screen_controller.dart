import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

class VideoControlScreenController extends GetxController {
  final isVideoToPlay = false.obs;

  late Player player;

  @override
  void onInit() {
    super.onInit();
    player = Player();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  void loadVideoFromUrl(String url){
    player.open(Media(url));
  }



}