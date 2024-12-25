import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rein_player/features/playback/views/video_action_controls.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

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
                const RpVideoActionControls(),
                const RpVideoTypeAndTimeCounter(),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(left: BorderSide(width: 1, color: RpColors.black))
                    ),
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

class RpVideoTypeAndTimeCounter extends StatelessWidget {
  const RpVideoTypeAndTimeCounter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
