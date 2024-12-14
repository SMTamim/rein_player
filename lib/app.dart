import 'package:flutter/material.dart';
import 'package:rein_player/features/playback/views/video_main_screen.dart';

import 'features/player_frame/views/window_frame.dart';
import 'features/playlist/views/playlist_sidebar.dart';


class RpApp extends StatelessWidget {
  const RpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Rein Player",
      debugShowCheckedModeBanner: false,
      home: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            RpWindowFrame(),
            Row(
              children: [
                RpVideoMainScreen(),
                RpPlaylistSideBar()
              ],
            )
          ],
        ),
      ),
    );
  }
}