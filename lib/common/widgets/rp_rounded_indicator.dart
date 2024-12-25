import 'package:flutter/material.dart';

import '../../utils/constants/rp_colors.dart';

class RpRoundedIndicator extends StatelessWidget {
  const RpRoundedIndicator({
    super.key,
    this.height = 6,
    this.width = 6,
  });

  final double height, width;
  final Color backgroundColor = RpColors.white;
  final double borderRadius = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius)),
    );
  }
}
