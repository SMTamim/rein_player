import 'package:flutter/material.dart';

import '../../../common/widgets/rp_horizontal_divider.dart';
import '../../../utils/constants/rp_colors.dart';

class RpWindowCurrentContentInfo extends StatelessWidget {
  const RpWindowCurrentContentInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("MPEG TS", style: Theme.of(context).textTheme.bodySmall),
          Container(
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            child: const RpHorizontalDivider(backgroundColor: RpColors.black_500),
          ),
          Text("[2/4] Ep. 02.ts", style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}