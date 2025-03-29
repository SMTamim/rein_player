import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playback/views/controls_screen.dart';
import 'package:rein_player/features/playback/views/video_screen.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';

class RpVideoAndControlsScreen extends StatelessWidget {
  const RpVideoAndControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      VideoAndControlController.to.videoAndControlScreenSize.value =
          constraint.minWidth;

      return Column(
        children: [
          /// video
          const Expanded(child: RpVideoScreen()),
          const SizedBox(height: 20),

          /// controls
          Obx(() {
            final isFullScreenMode =
                WindowActionsController.to.isFullScreenMode.value;
            return isFullScreenMode
                ? const SizedBox.shrink()
                : const RpControls();
          }),
        ],
      );
    });
  }
}
