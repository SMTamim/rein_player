import 'package:flutter/material.dart';

import '../../utils/constants/rp_colors.dart';

class RpHorizontalDivider extends StatelessWidget {
  const RpHorizontalDivider({
    super.key,
    this.height = 1,
    this.backgroundColor = RpColors.black,
    this.width = double.infinity,
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
