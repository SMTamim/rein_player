import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widgets/rp_rounded_indicator.dart';
import '../../../utils/constants/rp_colors.dart';

class RpVolumeBar extends StatelessWidget {
  const RpVolumeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/volume.svg"),
          const SizedBox(width: 8),
          SizedBox(
            height: double.infinity,
            width: 63,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft ,
                  child: Container(
                    height: 2,
                    color: RpColors.black,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft ,
                  child: Container(
                    width: 5,
                    height: 2,
                    color: RpColors.accent,
                  ),
                ),
                const Align(
                    alignment: Alignment(-0.8, 0),
                    child: RpRoundedIndicator()
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
