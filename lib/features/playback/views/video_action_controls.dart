import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playback/controller/video_controls_controller.dart';

import '../../../common/widgets/rp_horizontal_divider.dart';

class RpVideoActionControls extends StatelessWidget {
  const RpVideoActionControls({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// play  or pause
          Obx(() {
            return VideoAndControlController.to.isVideoPlaying.value
                ? _buildControlButton(
                    assetPath: "assets/icons/pause.svg",
                    onTap: ControlsController.to.pause,
                  )
                : _buildControlButton(
                    assetPath: "assets/icons/play.svg",
                    onTap: ControlsController.to.play,
                  );
          }),
          const RpVerticalDivider(),

          /// stop
          _buildControlButton(
            assetPath: "assets/icons/stop_video.svg",
            onTap:  ControlsController.to.stop,
          ),
          const RpVerticalDivider(),

          /// previous
          _buildControlButton(
            assetPath: "assets/icons/previous.svg",
            onTap: () {},
          ),
          const RpVerticalDivider(),

          /// next
          _buildControlButton(
            assetPath: "assets/icons/next.svg",
            onTap: () {},
          ),
          const RpVerticalDivider(),

          /// open
          _buildControlButton(
            assetPath: "assets/icons/open_video.svg",
            onTap: ControlsController.to.pause,
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
