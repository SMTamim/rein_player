import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/playback_speed_controller.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

class PlaybackSpeedOverlay extends StatelessWidget {
  const PlaybackSpeedOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!PlaybackSpeedController.to.showOverlay.value) {
        return const SizedBox.shrink();
      }

      return Positioned(
        top: 20,
        left: 20,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: RpColors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.speed,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                PlaybackSpeedController.to.speedText,
                style: const TextStyle(
                  color: RpColors.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
