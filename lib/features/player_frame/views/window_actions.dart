import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

import '../../../common/widgets/rp_horizontal_divider.dart';

class RpWindowActions extends StatelessWidget {
  RpWindowActions({
    super.key,
  });

  final windowActionsController = Get.put(WindowActionsController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const RpVerticalDivider(),
        const SizedBox(width: 10),
        Obx(
          () => GestureDetector(
            onTap: windowActionsController.togglePin,
            child: windowActionsController.isPinned.value
                ? SvgPicture.asset(
                    "assets/icons/pin_down.svg",
                    colorFilter:
                        const ColorFilter.mode(RpColors.accent, BlendMode.srcIn),
                  )
                : SvgPicture.asset("assets/icons/pin_left.svg"),
          ),
        ),
        const SizedBox(width: 13),
        GestureDetector(
          onTap: windowActionsController.minimizeWindow,
          child: SizedBox(height: 58 ,child: SvgPicture.asset("assets/icons/minimize.svg")),
        ),
        const SizedBox(width: 13),
        GestureDetector(
          onTap: windowActionsController.maximizeOrRestoreWindow,
          child: SvgPicture.asset("assets/icons/maximize.svg"),
        ),
        // SizedBox(width: 13),
        // GestureDetector(
        //   onTap: windowActionsController.fullscreenWindow,
        //   child: SvgPicture.asset("assets/icons/fullscreen.svg"),
        // ),
        const SizedBox(width: 13),
        GestureDetector(
          onTap: windowActionsController.closeWindow,
          child: SvgPicture.asset("assets/icons/close.svg"),
        ),
        const SizedBox(width: 9)
      ],
    );
  }
}
