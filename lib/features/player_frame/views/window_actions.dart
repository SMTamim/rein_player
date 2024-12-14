import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widgets/rp_horizontal_divider.dart';

class RpWindowActions extends StatelessWidget {
  const RpWindowActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RpHorizontalDivider(),
        SizedBox(width: 10),
        GestureDetector(
          onTap: (){},
          child: SvgPicture.asset("assets/icons/pin_left.svg"),
        ),
        SizedBox(width: 13),
        GestureDetector(
          onTap: (){},
          child: SvgPicture.asset("assets/icons/minimize.svg"),
        ),
        SizedBox(width: 13),
        GestureDetector(
          onTap: (){},
          child: SvgPicture.asset("assets/icons/maximize.svg"),
        ),
        SizedBox(width: 13),
        GestureDetector(
          onTap: (){},
          child: SvgPicture.asset("assets/icons/fullscreen.svg"),
        ),
        SizedBox(width: 13),
        GestureDetector(
          onTap: (){},
          child: SvgPicture.asset("assets/icons/close.svg"),
        ),
        SizedBox(width: 9)
      ],
    );
  }
}

