import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rein_player/common/widgets/rp_horizontal_divider.dart';
import 'package:rein_player/features/player_frame/views/window_actions.dart';
import 'package:rein_player/features/player_frame/views/window_current_content_info.dart';
import 'package:rein_player/features/player_frame/views/window_player_menu.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

class RpWindowFrame extends StatelessWidget {
  const RpWindowFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      margin: EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: RpColors.gray_900,
      ),
      child: Row(
        children: [
          /// menu
          Row(
            children: [
              /// player name and menu
              RpWindowPlayerMenu(),

              /// black line
              const RpHorizontalDivider(),

              /// video info
              const RpWindowCurrentContentInfo(),
            ],
          ),
          
          /// move window around
          Expanded(
            child: MoveWindow(),
          ),

          /// window icons
          RpWindowActions()
        ],
      )
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: Color(0xFF2B2B2B),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.menu, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Menu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}