import 'package:flutter/material.dart';
import 'package:rein_player/features/playback/views/video_controls.dart';
import 'package:rein_player/features/playback/views/video_screen.dart';

class RpVideoAndControlsScreen extends StatelessWidget {
  const RpVideoAndControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Expanded(child: RpVideoScreen()),
          SizedBox(height: 20),
          RpVideoControls()
        ],
      );
  }
}
