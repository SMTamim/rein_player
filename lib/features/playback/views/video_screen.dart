import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:rein_player/features/playback/controller/video_control_screen_controller.dart';

class RpVideoScreen extends StatelessWidget {
  const RpVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(VideoAndControlScreenController());

    videoController.currentVideoOrAudioUrl.value = "https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4";
    videoController.loadVideoFromUrl(videoController.currentVideoOrAudioUrl.value);
    final videoPlayerController =  VideoController(videoController.player);
    videoPlayerController.player.pause();

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        child: Video(controller: videoPlayerController, controls: NoVideoControls),
      ),
    );
  }
}
