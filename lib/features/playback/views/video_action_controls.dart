import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/controls_controller.dart';

import '../../../common/widgets/rp_horizontal_divider.dart';

class RpVideoActionControls extends StatelessWidget {
  RpVideoActionControls({super.key});

  final videoActionsController = Get.put(ControlsController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(
            assetPath: "assets/icons/pause.svg",
            onTap: videoActionsController.pause,
          ),
          const RpVerticalDivider(),
          _buildControlButton(
            assetPath: "assets/icons/play.svg",
            onTap: videoActionsController.play,
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
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent, // Ensures the container is tappable
        child: SvgPicture.asset(
          assetPath,
        ),
      ),
    );
  }
}
