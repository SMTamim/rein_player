import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rein_player/common/widgets/rp_horizontal_divider.dart';
import 'package:rein_player/features/playback/views/video_action_controls.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';
import 'package:rein_player/utils/device/rp_device_utils.dart';

import 'duration_and_volume.dart';

class RpVideoControls extends StatelessWidget {
  const RpVideoControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, left: 3, bottom: 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Duration and volume controls
          const RpDurationAndVolume(),
          const SizedBox(height: 2),

          // Action controls
          Container(
            width: double.infinity,
            color: RpColors.gray_900,
            child: Row(
              children: [
                RpVideoActionControls(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("00:00:02",
                          style: Theme.of(context).textTheme.bodySmall),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text("/",style:  Theme.of(context).textTheme.labelSmall!.copyWith(color: RpColors.black_500))
                      ),
                      Text("04:00:02",
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: SvgPicture.asset("assets/icons/playlist_burger.svg"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
