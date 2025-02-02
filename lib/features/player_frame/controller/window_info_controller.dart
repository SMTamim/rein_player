import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';

class WindowInfoController extends GetxController {
  static WindowInfoController get to => Get.find();

  String getFileType(){
    final currentVideo = VideoAndControlController.to.currentVideo.value;
    if(currentVideo == null ) return "";
    return currentVideo.extension.toUpperCase().replaceAll(".", "");
  }

  String getCurrentVideoTitle() {
    final currentVideo = VideoAndControlController.to.currentVideo.value;
    if (currentVideo == null) return "";
    final String fullName = currentVideo.name;
    final int extensionIndex = fullName.lastIndexOf(".");
    return  extensionIndex != -1 ? fullName.substring(0, extensionIndex) : fullName;
  }

}