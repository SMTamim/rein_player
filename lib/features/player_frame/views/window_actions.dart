import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rein_player/core/app_icons.dart';
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
          () => InkWell(
            onTap: WindowActionsController.to.togglePin,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: RpSizes.sm),
              height: 58,
              child: WindowActionsController.to.isPinned.value
                  ? SvgPicture.asset(
                      AppIcons.pinDownIcon,
                      colorFilter: const ColorFilter.mode(
                          RpColors.accent, BlendMode.srcIn),
                    )
                  : SvgPicture.asset(AppIcons.pinDownIcon),
            ),
          ),
        ),
        const SizedBox(width: 10),

        /// minimize
        InkWell(
          onTap: WindowActionsController.to.minimizeWindow,
          child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: RpSizes.sm),
              height: 58,
              child: SvgPicture.asset(AppIcons.minimizeIcon)),
        ),
        const SizedBox(width: 10),

        /// maximize
        InkWell(
          onTap: WindowActionsController.to.maximizeOrRestoreWindow,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: RpSizes.sm),
            height: 58,
            child: SvgPicture.asset(AppIcons.maximizeIcon),
          ),
        ),

        /// fullscreen mode
        const SizedBox(width: 10),
        InkWell(
          onTap: WindowActionsController.to.toggleFullScreenWindow,
          child: SvgPicture.asset(AppIcons.fullscreenIcon),
        ),
        const SizedBox(width: 10),

        /// close
        InkWell(
          onTap: WindowActionsController.to.closeWindow,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: RpSizes.sm),
            height: 58,
            child: SvgPicture.asset(AppIcons.closeIcon),
          ),
        ),
        const SizedBox(width: 9)
      ],
    );
  }
}
