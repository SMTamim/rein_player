import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';

class WindowInfoController extends GetxController {
  static WindowInfoController get to => Get.find();

  String getFileType(){
    final currentVideo = VideoAndControlController.to.currentVideo?.value;
    if(currentVideo == null ) return "";
    return currentVideo.extension.toUpperCase();
  }

  String getCurrentVideoTitle(){
    final currentVideo = VideoAndControlController.to.currentVideo?.value;
    if(currentVideo == null ) return "";
    return currentVideo.name;
  }
}