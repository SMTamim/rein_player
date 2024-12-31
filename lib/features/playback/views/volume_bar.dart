import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_control_screen_controller.dart';

import '../../../common/widgets/rp_rounded_indicator.dart';
import '../../../utils/constants/rp_colors.dart';

class RpVolumeBar extends StatelessWidget {
  RpVolumeBar({super.key});

  final GlobalKey sliderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/volume.svg"),
          const SizedBox(width: 8),
          GestureDetector(
            onPanUpdate: (details) {
              double newVolume =
                  VideoAndControlController.to.currentVolume.value +
                      details.delta.dx / 50;
              newVolume = newVolume.clamp(0.0, 1.0);
              VideoAndControlController.to.updateVolume(newVolume);
            },
            onTapDown: (details) {
              RenderBox box =
                  sliderKey.currentContext!.findRenderObject() as RenderBox;
              double containerWidth = box.size.width;
              double localDx = details.localPosition.dx;
              double newVolume = (localDx / containerWidth).clamp(0.0, 1.0);
              VideoAndControlController.to.updateVolume(newVolume);
            },
            child: Obx(
              () => SizedBox(
                height: double.infinity,
                width: 63,
                child: Stack(
                  key: sliderKey,
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 2,
                      color: RpColors.black,
                    ),
                    FractionallySizedBox(
                      widthFactor:
                          VideoAndControlController.to.currentVolume.value,
                      child: Container(
                        height: 2,
                        color: RpColors.accent,
                      ),
                    ),
                    Align(
                      alignment: Alignment(
                          VideoAndControlController.to.currentVolume.value * 2 -
                              1,
                          0),
                      child: RpRoundedIndicator(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
