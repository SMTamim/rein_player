import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          _buildControlButton(
            assetPath: "assets/icons/play.svg",
            onTap: ControlsController.to.play,
          ),
          const RpVerticalDivider(),
          _buildControlButton(
            assetPath: "assets/icons/pause.svg",
            onTap: ControlsController.to.pause,
          ),
          const RpVerticalDivider(),
          _buildControlButton(
            assetPath: "assets/icons/previous.svg",
            onTap: () {},
          ),
          const RpVerticalDivider(),
          _buildControlButton(
            assetPath: "assets/icons/next.svg",
            onTap: () {},
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
        color: Colors.transparent, // Ensures the container is tappable
        child: SvgPicture.asset(
          assetPath,
        ),
      ),
    );
  }
}
