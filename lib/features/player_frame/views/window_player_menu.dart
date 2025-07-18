import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rein_player/core/app_icons.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';

import '../../../utils/constants/rp_colors.dart';

class RpWindowPlayerMenu extends StatelessWidget {
  const RpWindowPlayerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          Offset position = renderBox.localToGlobal(Offset.zero);
          MainMenuController.to.showMainMenu(context, position + const Offset(0, 25));
        },
        onExit: (_) {
          MainMenuController.to.isHoveringMain.value = false;
          Future.delayed(const Duration(milliseconds: 100), () {
            if (!MainMenuController.to.isHoveringMain.value) {
              MainMenuController.to.hideMenu();
            }
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ReinPlayer",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              AppIcons.chevronDownIcon,
              colorFilter: const ColorFilter.mode(RpColors.black_300, BlendMode.srcIn),
            )
          ],
        ),
      ),
    );
  }
}