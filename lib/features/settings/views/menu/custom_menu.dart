import 'package:flutter/material.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';
import 'package:rein_player/features/playback/controller/subtitle_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

class RpCustomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => MainMenuController.to.isHovering.value = true,
      onExit: (_) {
        MainMenuController.to.isHovering.value = false;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (!MainMenuController.to.isHovering.value) {
            MainMenuController.to.hideMenu();
          }
        });
      },
      child: Material(
        color: RpColors.gray_800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuItem(text: "Open File", onTap: () {
              ControlsController.to.open();
            }),

             MenuItem(
              text: "Subtitles",
              subMenuItems: [
                MenuItem(text: "Add Subtitle", onTap: SubtitleController.to.loadSubtitle),
                MenuItem(text: "Disable Subtitle", onTap: SubtitleController.to.disableSubtitle),
              ],
            ),
            MenuItem(text: "Exit", onTap: (){
              WindowActionsController.to.closeWindow();
            }),
          ],
        ),
      ),
    );
  }
}