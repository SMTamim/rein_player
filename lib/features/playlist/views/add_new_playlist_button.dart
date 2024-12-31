import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/rp_colors.dart';

class RpAddNewPlaylistButton extends StatelessWidget {
  const RpAddNewPlaylistButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(
          horizontal: 23, vertical: 13),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
              width: 1, color: RpColors.black),
          bottom: BorderSide(
              width: 1, color: RpColors.black),
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Icon(Iconsax.add, size: 16,)
        ),
      ),
    );
  }
}
