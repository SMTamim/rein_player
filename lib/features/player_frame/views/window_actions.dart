import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';

import '../../../common/widgets/rp_vertical_divider.dart';

class RpWindowActions extends StatelessWidget {
  const RpWindowActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const RpVerticalDivider(),
        const SizedBox(width: 10),

        /// pin window
        Obx(
          () => GestureDetector(
            onTap: WindowActionsController.to.togglePin,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: RpSizes.sm),
              height: 58,
              child: WindowActionsController.to.isPinned.value
                  ? SvgPicture.asset(
                      "assets/icons/pin_down.svg",
                      colorFilter: const ColorFilter.mode(
                          RpColors.accent, BlendMode.srcIn),
                    )
                  : SvgPicture.asset("assets/icons/pin_left.svg"),
            ),
          ),
        ),
        const SizedBox(width: 10),

        /// minimize
        GestureDetector(
          onTap: WindowActionsController.to.minimizeWindow,
          child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: RpSizes.sm),
              height: 58,
              child: SvgPicture.asset("assets/icons/minimize.svg")),
        ),
        const SizedBox(width: 10),

        /// maximize
        GestureDetector(
          onTap: WindowActionsController.to.maximizeOrRestoreWindow,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: RpSizes.sm),
            height: 58,
            child: SvgPicture.asset("assets/icons/maximize.svg"),
          ),
        ),

        /// fullscreen mode
        // SizedBox(width: 10),
        // GestureDetector(
        //   onTap: WindowActionsController.to.fullscreenWindow,
        //   child: SvgPicture.asset("assets/icons/fullscreen.svg"),
        // ),
        const SizedBox(width: 10),

        /// close
        GestureDetector(
          onTap: WindowActionsController.to.closeWindow,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: RpSizes.sm),
            height: 58,
            child: SvgPicture.asset("assets/icons/close.svg"),
          ),
        ),
        const SizedBox(width: 9)
      ],
    );
  }
}
