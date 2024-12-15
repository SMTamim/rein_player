import 'package:flutter/material.dart';
import 'package:rein_player/features/playback/views/video_screen.dart';

class RpVideoControlsScreen extends StatelessWidget {
  const RpVideoControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          RpVideoScreen(),
          SizedBox(height: 20),
          Text('controls')
        ],
      );
  }
}
