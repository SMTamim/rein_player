import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_control_screen_controller.dart';

import '../../../common/widgets/rp_rounded_indicator.dart';
import '../../../utils/constants/rp_colors.dart';

class RpVideoProgressBar extends StatelessWidget {
  RpVideoProgressBar({
    super.key,
  });

  final GlobalKey progressBarKey = GlobalKey();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        RenderBox box =
            progressBarKey.currentContext!.findRenderObject() as RenderBox;
        double localDx = details.localPosition.dx;
        double totalWidth = box.size.width;
        double newProgress = (localDx / totalWidth).clamp(0.0, 1.0);
        VideoAndControlController.to.updateVideoProgress(newProgress);
      },
      onTapDown: (TapDownDetails details) {
        RenderBox box =
            progressBarKey.currentContext!.findRenderObject() as RenderBox;
        double localDx = details.localPosition.dx;
        double totalWidth = box.size.width;
        double newProgress = (localDx / totalWidth).clamp(0.0, 1.0);
        VideoAndControlController.to.updateVideoProgress(newProgress);
      },
      child: Obx(
        () => Container(
          color: RpColors.gray_900,
          height: double.infinity,
          child: Stack(
            key: progressBarKey,
            alignment: Alignment.centerLeft,
            children: [
              FractionallySizedBox(
                widthFactor:
                    VideoAndControlController.to.currentVideoProgress.value,
                child: Container(
                  height: 2,
                  color: RpColors.accent,
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: RpColors.black_600,
              ),
              Align(
                alignment: Alignment(
                    VideoAndControlController.to.currentVideoProgress.value *
                            2 -
                        1,
                    0),
                child: RpRoundedIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
