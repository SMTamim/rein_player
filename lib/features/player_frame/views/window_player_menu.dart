import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';

import '../../../utils/constants/rp_colors.dart';

class RpWindowPlayerMenu extends StatelessWidget {
  const RpWindowPlayerMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset position = renderBox.localToGlobal(Offset.zero);
        MainMenuController.to.showMainMenu(context, position + Offset(0, 50));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ReinPlayer",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              "assets/icons/chevron_down.svg",
              colorFilter: const ColorFilter.mode(RpColors.black_300, BlendMode.srcIn),
            )
          ],
        ),
      ),
    );
  }
}
