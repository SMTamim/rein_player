import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
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
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: RpColors.gray_900,
      ),
      child: MoveWindow(
        child:  const Row(
          children: [
            /// menu
            Row(
              children: [
                /// player name and menu
                RpWindowPlayerMenu(),
        
                /// black line
                RpVerticalDivider(),
        
                /// video info
                RpWindowCurrentContentInfo(),
              ],
            ),
            Spacer(),
        
            /// window icons
            RpWindowActions()
          ],
        ),
      )
    );
  }
}