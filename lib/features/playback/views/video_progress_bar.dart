import 'package:flutter/material.dart';

import '../../../common/widgets/rp_rounded_indicator.dart';
import '../../../utils/constants/rp_colors.dart';

class RpVideoProgressBar extends StatelessWidget {
  const RpVideoProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 1,
            width: double.infinity,
            color: RpColors.black_600,
          ),
        ),
        const Align(alignment: Alignment(-1, 0), child: RpRoundedIndicator())
      ],
    );
  }
}
