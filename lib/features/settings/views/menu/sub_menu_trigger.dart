import 'package:flutter/material.dart';

import 'package:rein_player/features/settings/controller/menu_controller.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';


class SubmenuTrigger extends StatelessWidget {
  final String text;
  final List<MenuItem> submenuItems;

  SubmenuTrigger({required this.text, required this.submenuItems});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset position = renderBox.localToGlobal(Offset.zero);
        MainMenuController.to.onHover(true, context, position, submenuItems);
      },
      onExit: (_) {
        MainMenuController.to.onHover(false, context, Offset.zero, []);
      },
      child: MenuItem(text: text),
    );
  }
}


