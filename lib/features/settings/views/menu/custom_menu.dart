import 'package:flutter/material.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';
import 'package:rein_player/features/settings/views/menu/menu_items.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

class RpCustomMenu extends StatelessWidget {
  const RpCustomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        MainMenuController.to.isHoveringMain.value = true;
      },
      onExit: (_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (MainMenuController.to.isHoveringSub.value) {
            MainMenuController.to.isHoveringMain.value = true;
          } else {
            MainMenuController.to.hideMenu();
          }
        });
      },
      child: Material(
        color: RpColors.gray_800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: defaultMenuData,
        ),
      ),
    );
  }
}
