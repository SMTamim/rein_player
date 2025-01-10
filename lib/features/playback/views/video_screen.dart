import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:rein_player/features/playback/controller/video_control_screen_controller.dart';

class RpVideoScreen extends StatelessWidget {
  const RpVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(VideoAndControlController());

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        child: GestureDetector(
          onDoubleTap: () {},
          child: Video(
            controller: videoController.videoPlayerController,
            controls: NoVideoControls,
          ),
        ),
      ),
    );
  }
}
