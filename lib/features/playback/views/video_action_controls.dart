import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rein_player/core/app_icons.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';

import '../../../common/widgets/rp_vertical_divider.dart';

class RpVideoActionControls extends StatelessWidget {
  const RpVideoActionControls({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// play  or pause
          Obx(() {
            return VideoAndControlController.to.isVideoPlaying.value
                ? _buildControlButton(
                    assetPath: AppIcons.pauseIcon,
                    onTap: ControlsController.to.pause,
                  )
                : _buildControlButton(
                    assetPath: AppIcons.playIcon,
                    onTap: ControlsController.to.play,
                  );
          }),
          const RpVerticalDivider(),

          /// stop
          _buildControlButton(
            assetPath: AppIcons.stopIcon,
            onTap:  ControlsController.to.stop,
          ),
          const RpVerticalDivider(),

          /// previous
          _buildControlButton(
            assetPath: AppIcons.previousIcon,
            onTap: ControlsController.to.goPreviousItemInPlaylist,
          ),
          const RpVerticalDivider(),

          /// next
          _buildControlButton(
            assetPath: AppIcons.nextIcon,
            onTap: ControlsController.to.goNextItemInPlaylist,
          ),
          const RpVerticalDivider(),

          /// open
          _buildControlButton(
            assetPath: AppIcons.openVideoIcon,
            onTap: ControlsController.to.open,
          ),
          const RpVerticalDivider(),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required String assetPath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent,
        height: double.infinity,
        child: SvgPicture.asset(
          assetPath,
        ),
      ),
    );
  }
}
