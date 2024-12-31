import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_control_screen_controller.dart';
import 'package:rein_player/features/playback/views/video_controls.dart';
import 'package:rein_player/features/playback/views/video_screen.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';

class RpVideoAndControlsScreen extends StatelessWidget {
  const RpVideoAndControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {

      return LayoutBuilder(
        builder: (context, constraint) {
          VideoAndControlController.to.videoAndControlScreenSize.value  = constraint.minWidth;

          return const Column(
            children: [
              /// video
              Expanded(child: RpVideoScreen()),
              SizedBox(height: 20),

              /// controls
              RpVideoControls()
            ],
          );
        }
      );
  }
}
