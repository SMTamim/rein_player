import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/settings/views/menu/custom_menu.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';
import 'package:rein_player/features/settings/views/menu/sub_menu.dart';

class MainMenuController extends GetxController {
  static MainMenuController get to => Get.find();

  OverlayEntry? overlayEntry;
  OverlayEntry? submenuOverlay;

  RxBool isHovered = false.obs;

  void showMainMenu(BuildContext context, Offset position) {
    hideMenu();
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: RpCustomMenu(),
      ),
    );
    Overlay.of(context).insert(overlayEntry!);
  }

  void showSubmenu(BuildContext context, Offset position, List<MenuItem> submenuItems) {
    hideSubmenu();
    submenuOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 200, // Offset submenu to the right of main menu
        top: position.dy,
        child: Submenu(items: submenuItems),
      ),
    );
    Overlay.of(context).insert(submenuOverlay!);
  }

  void hideMenu() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void hideSubmenu() {
    submenuOverlay?.remove();
    submenuOverlay = null;
  }

  void onHover(bool value, BuildContext context, Offset position, List<MenuItem> submenuItems) {
    isHovered.value = value;
    if (value) {
      showSubmenu(context, position, submenuItems);
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!isHovered.value) hideSubmenu();
      });
    }
  }
}
