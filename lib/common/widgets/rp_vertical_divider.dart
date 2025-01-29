import 'package:flutter/material.dart';

import '../../utils/constants/rp_colors.dart';

class RpVerticalDivider extends StatelessWidget {
  const RpVerticalDivider({
    super.key,
    this.height = double.infinity,
    this.backgroundColor = RpColors.black,
    this.width = 1,
  });

  final double height, width;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: backgroundColor,
    );
  }
}
