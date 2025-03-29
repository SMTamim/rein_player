import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';

import 'no_media_placeholder.dart';

class RpVideoScreen extends StatelessWidget {
  const RpVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(VideoAndControlController());

    return MouseRegion(
      onHover: (_) => MainMenuController.to.hideMenu,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9.0 / 16.0,
          child: GestureDetector(
            onDoubleTap: WindowActionsController.to.toggleWindowSize,
            child: Obx(() {
              if (VideoAndControlController.to.currentVideoUrl.isEmpty) {
                return const RpNoMediaPlaceholder();
              }
              return Video(
                key: ValueKey(VideoAndControlController.to.currentVideoUrl),
                controller: videoController.videoPlayerController,
                controls: NoVideoControls,
              );
            }),
          ),
        ),
      ),
    );
  }
}
