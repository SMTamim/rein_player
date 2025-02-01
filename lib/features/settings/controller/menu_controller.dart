import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/settings/views/menu/custom_menu.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';
import 'package:rein_player/features/settings/views/menu/sub_menu.dart';

class MainMenuController extends GetxController {
  static MainMenuController get to => Get.find();

  OverlayEntry? overlayEntry;
  final List<OverlayEntry> submenuOverlays = [];
  RxBool isHoveringMain = false.obs;
  RxBool isHoveringSub = false.obs;

  void showMainMenu(BuildContext context, Offset position) {
    hideMenu();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: const RpCustomMenu(),
      ),
    );
    Overlay.of(context)!.insert(overlayEntry!);
    isHoveringMain.value = true;
  }

  void showSubmenu(BuildContext context, Offset position, List<MenuItem> submenuItems) {
    hideSubmenusFromLevel(submenuOverlays.length);

    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 200,
        top: position.dy,
        child: MouseRegion(
          onEnter: (_) => isHoveringSub.value = true,
          onExit: (_) {
            Future.delayed(const Duration(milliseconds: 150), () {
              if (!isHoveringSub.value) {
                hideSubmenu();
              }
            });
          },
          child: Submenu(items: submenuItems),
        ),
      ),
    );
    Overlay.of(context)!.insert(overlay);
    submenuOverlays.add(overlay);
  }

  void hideMenu() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
      isHoveringMain.value = false;
    }
    hideAllSubmenus();
  }

  void hideSubmenu() {
    if (submenuOverlays.isNotEmpty) {
      final overlay = submenuOverlays.removeLast();
      overlay.remove();
      isHoveringSub.value = false;
    }
  }

  void hideAllSubmenus() {
    while (submenuOverlays.isNotEmpty) {
      hideSubmenu();
    }
  }

  void hideSubmenusFromLevel(int level) {
    while (submenuOverlays.length >= level + 1) {
      hideSubmenu();
    }
  }

  void onMainHover(bool value, BuildContext context, Offset position, List<MenuItem> submenuItems) {
    isHoveringMain.value = value;
    showSubmenu(context, position, submenuItems);
  }

}