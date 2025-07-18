import 'package:flutter/material.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

class RpMenuItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final List<RpMenuItem>? subMenuItems;
  final bool enabled;

  const RpMenuItem({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.subMenuItems,
    this.enabled = true,
  });

  bool get hasSubMenu => subMenuItems != null && subMenuItems!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return hasSubMenu
        ? _buildWithSubMenu(context)
        : _buildWithoutSubMenu(context);
  }

  Widget _buildWithSubMenu(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleMouseEnter(context),
      onExit: (_) => _handleMouseExit(context),
      cursor: SystemMouseCursors.click,
      child: _buildMenuContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: _menuTextStyle),
            const Icon(Icons.chevron_right, color: Colors.white, size: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildWithoutSubMenu(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        MainMenuController.to.hideMenu();
      },
      child: _buildMenuContainer(
        child: Text(text, style: _menuTextStyle),
      ),
    );
  }

  Widget _buildMenuContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 3),
      width: 200,
      decoration: const BoxDecoration(
        color: RpColors.gray_800,
      ),
      child: child,
    );
  }

  void _handleMouseEnter(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    MainMenuController.to.isHoveringMain.value = true;
    MainMenuController.to.onMainHover(true, context, position, subMenuItems!);
  }

  void _handleMouseExit(BuildContext context) {
    if(!MainMenuController.to.isHoveringSub.value){
      MainMenuController.to.hideSubmenu();
    }
  }

  TextStyle get _menuTextStyle => const TextStyle(color: Colors.white, fontSize: 12);
}
