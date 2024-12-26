import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/views/video_control_screen.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/utils/theme/theme.dart';

import 'features/player_frame/views/window_frame.dart';
import 'features/playlist/views/playlist_sidebar.dart';

class RpApp extends StatelessWidget {
  RpApp({super.key});

  final playlistController = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rein Player",
      debugShowCheckedModeBanner: false,
      darkTheme: RpAppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              /// custom window frame
              RpWindowFrame(),

              /// video screen and controls
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: RpVideoAndControlsScreen()),
                    Obx(() {
                      return playlistController.isPlaylistWindowOpened.value
                          ? RpPlaylistSideBar()
                          : SizedBox.shrink();
                    })
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
