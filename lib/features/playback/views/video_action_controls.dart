import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widgets/rp_horizontal_divider.dart';

class RpVideoActionControls extends StatelessWidget {
  const RpVideoActionControls({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(
            assetPath: "assets/icons/pause.svg",
            onTap: () {},
          ),
          const RpVerticalDivider(),
          _buildControlButton(
            assetPath: "assets/icons/play.svg",
            onTap: () {},
          ),
          const RpVerticalDivider(),
          _buildControlButton(
            assetPath: "assets/icons/previous.svg",
            onTap: () {},
          ),
          const RpVerticalDivider(),
          _buildControlButton(
            assetPath: "assets/icons/next.svg",
            onTap: () {},
          ),
          const RpVerticalDivider(),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required String assetPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SvgPicture.asset(
          assetPath,
        ),
      ),
    );
  }
}
