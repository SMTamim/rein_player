import 'package:flutter/material.dart';
import 'package:rein_player/features/playback/views/video_control_screen.dart';
import 'package:rein_player/utils/theme/theme.dart';

import 'features/player_frame/views/window_frame.dart';


class RpApp extends StatelessWidget {
  const RpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Rein Player",
      debugShowCheckedModeBanner: false,
      darkTheme: RpAppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: const Column(
            children: [
              /// custom window frame
              RpWindowFrame(),

              /// video screen and controls
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: RpVideoAndControlsScreen()),
                    // RpPlaylistSideBar()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}