import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/settings/views/menu/custom_menu.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';
import 'package:rein_player/features/settings/views/menu/sub_menu.dart';
import 'package:rein_player/main.dart';

class MainMenuController extends GetxController {
  static MainMenuController get to => Get.find();

  Rx<OverlayEntry?> overlayEntry = Rx<OverlayEntry?>(null);
  OverlayEntry? submenuOverlay;
  RxBool isHovering = false.obs;

  void showMainMenu(BuildContext context, Offset position) {
    overlayEntry.value = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: RpCustomMenu(),
      ),
    );
    Overlay.of(context).insert(overlayEntry.value!);
    isHovering.value = true;
  }

  void showSubmenu(BuildContext context, Offset position, List<MenuItem> submenuItems) {
    hideSubmenu();
    submenuOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 200,
        top: position.dy,
        child: Submenu(items: submenuItems),
      ),
    );
    Overlay.of(context).insert(submenuOverlay!);
  }

  void hideMenu() {
    print("now here ${isHovering.value}");
    if (!isHovering.value) {
      print("hiding menu");
      overlayEntry.value?.remove();
      overlayEntry.value = null;
      hideSubmenu();
    }
    print("HHHH: $overlayEntry");
  }

  void hideSubmenu() {
    submenuOverlay?.remove();
    submenuOverlay = null;
  }

  void onHover(bool value, BuildContext context, Offset position, List<MenuItem> submenuItems) {
    isHovering.value = value;
    if (value) {
      showSubmenu(context, position, submenuItems);
    } else {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!isHovering.value) hideSubmenu();
      });
    }
  }
}