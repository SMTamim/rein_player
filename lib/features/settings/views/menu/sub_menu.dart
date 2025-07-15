import 'package:flutter/material.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

import '../../controller/menu_controller.dart';
import 'menu_item.dart';

class Submenu extends StatelessWidget {
  final List<MenuItem> items;

  const Submenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => MainMenuController.to.isHoveringSub.value = true,
      onExit: (_) {
        MainMenuController.to.isHoveringSub.value = false;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (!MainMenuController.to.isHoveringSub.value) {
            MainMenuController.to.hideSubmenu();
            MainMenuController.to.hideMenu();
          }
        });
      },
      child: Material(
        color: RpColors.gray_800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ),
    );
  }
}