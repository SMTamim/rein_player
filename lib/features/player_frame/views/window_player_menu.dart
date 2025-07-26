import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:rein_player/utils/constants/rp_app_icons.dart';
import 'package:rein_player/features/settings/views/menu/menu_items.dart';

import '../../../utils/constants/rp_colors.dart';

class RpWindowPlayerMenu extends StatefulWidget {
  const RpWindowPlayerMenu({super.key});

  @override
  State<RpWindowPlayerMenu> createState() => _RpWindowPlayerMenuState();
}

class _RpWindowPlayerMenuState extends State<RpWindowPlayerMenu> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: ContextMenuRegion(
        contextMenu: createContextMenu(),
        child: GestureDetector(
          onTap: () {
            // Show context menu on left-click
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final Offset position = renderBox.localToGlobal(Offset.zero);

            final menu = createContextMenu();
            showContextMenu(
              context,
              contextMenu: ContextMenu(
                entries: menu.entries,
                position: position + const Offset(0, 25),
                boxDecoration: menu.boxDecoration,
                padding: menu.padding,
              ),
            );
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _isHovered
                    ? RpColors.gray_800.withValues(alpha: 0.8)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "ReinPlayer",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: _isHovered
                              ? RpColors.accent
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    RpAppIcons.chevronDownIcon,
                    colorFilter: ColorFilter.mode(
                        _isHovered ? RpColors.accent : RpColors.black_300,
                        BlendMode.srcIn),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
