import 'package:flutter/material.dart';
import 'package:rein_player/features/playback/views/video_progress_bar.dart';
import 'package:rein_player/features/playback/views/volume_bar.dart';

import '../../../utils/constants/rp_colors.dart';

class RpVideoProgressAndVolume extends StatelessWidget {
  const RpVideoProgressAndVolume({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: double.infinity,
      color: RpColors.gray_900,
      child: Row(
        children: [
          /// duration
          Expanded(
            child: RpVideoProgressBar(),
          ),
          const SizedBox(width: 20),

          /// volume
          RpVolumeBar()
        ],
      ),
    );
  }
}
