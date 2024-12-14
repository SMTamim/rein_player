import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/rp_colors.dart';

class RpWindowPlayerMenu extends StatelessWidget {
  const RpWindowPlayerMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ReinPlayer", style: Theme.of(context).textTheme.bodyMedium,),
          SizedBox(width: 8),
          SvgPicture.asset("assets/icons/chevron_down.svg", colorFilter: ColorFilter.mode(RpColors.black_300, BlendMode.srcIn),)
        ],
      ),
    );
  }
}
