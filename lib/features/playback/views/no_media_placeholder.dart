import 'package:flutter/material.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

class RpNoMediaPlaceholder extends StatelessWidget {
  const RpNoMediaPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(text: "R", style: TextStyle(color: RpColors.accent, fontSize: 50)),
            TextSpan(text: "einPlayer", style: TextStyle(fontSize: 25, color: RpColors.gray_800))
          ],
        ),
      ),
    );
  }
}
