import 'package:flutter/material.dart';
import 'package:rein_player/features/settings/views/menu/menu_item.dart';
import 'package:rein_player/features/settings/views/menu/sub_menu_trigger.dart';

class RpCustomMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuItem(text: "Open File"),
          MenuItem(text: "Broadcast"),
          SubmenuTrigger(
            text: "Subtitles",
            submenuItems: [
              MenuItem(text: "Add Subtitle"),
              MenuItem(text: "Combine Subtitle"),
              MenuItem(text: "Cycle Subtitle"),
            ],
          ),
          SubmenuTrigger(
            text: "GoAhead",
            submenuItems: [
              MenuItem(text: "hear 1"),
              MenuItem(text: "hear 1"),
              MenuItem(text: "hear 1"),
            ],
          ),
          MenuItem(text: "Exit"),
        ],
      ),
    );
  }
}



