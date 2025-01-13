import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';

import '../../../common/widgets/rp_horizontal_divider.dart';
import '../../../utils/constants/rp_colors.dart';
import '../controller/window_info_controller.dart';

class RpWindowCurrentContentInfo extends StatelessWidget {
  const RpWindowCurrentContentInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Obx(() {
        return VideoAndControlController.to.currentVideo.value == null
            ? const SizedBox.shrink()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    WindowInfoController.to.getFileType(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Container(
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: const RpVerticalDivider(
                        backgroundColor: RpColors.black_500),
                  ),
                  Text(
                    "[2/4] ${WindowInfoController.to.getCurrentVideoTitle()}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
      }),
    );
  }
}
