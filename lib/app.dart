import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/bindings/general_bindings.dart';
import 'package:rein_player/features/playback/views/video_and_controls_screen.dart';
import 'package:rein_player/features/player_frame/controller/keyboard_shortcut_controller.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';
import 'package:rein_player/utils/theme/theme.dart';

import 'features/player_frame/views/window_frame.dart';
import 'features/playlist/views/playlist_sidebar.dart';

class RpApp extends StatelessWidget {
  RpApp({super.key});

  final playlistController = Get.put(PlaylistController());
  final keyboardController = Get.put(KeyboardController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      title: "Rein Player",
      debugShowCheckedModeBanner: false,
      darkTheme: RpAppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: KeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          onKeyEvent: keyboardController.handleKey,
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                /// custom window frame
                const RpWindowFrame(),

                Expanded(
                  child: Row(
                    children: [
                      /// video and controls screen
                      const Expanded(child: RpVideoAndControlsScreen()),

                      /// slider
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onHorizontalDragUpdate:
                            playlistController.updatePlaylistWindowSizeOnDrag,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.resizeColumn,
                          child: Container(width: 2, color: RpColors.black),
                        ),
                      ),

                      /// playlist
                      Obx(() {
                        return playlistController.isPlaylistWindowOpened.value
                            ? const RpPlaylistSideBar()
                            : const SizedBox.shrink();
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
