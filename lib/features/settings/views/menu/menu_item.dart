import 'package:flutter/material.dart';
import 'package:rein_player/features/settings/controller/menu_controller.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final List<MenuItem>? subMenuItems;

  const MenuItem({
    required this.text,
    this.onTap,
    this.subMenuItems,
  });

  @override
  Widget build(BuildContext context) {
    return subMenuItems != null ? _buildWithSubMenu(context) : _buildWithoutSubMenu();
  }

  Widget _buildWithSubMenu(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleMouseEnter(context),
      onExit: (_) => _handleMouseExit(),
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

  Widget _buildWithoutSubMenu() {
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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
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
    MainMenuController.to.isHovering.value = true;
    MainMenuController.to.onHover(true, context, position, subMenuItems!);
  }

  void _handleMouseExit() {
    MainMenuController.to.isHovering.value = false;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!MainMenuController.to.isHovering.value) {
        MainMenuController.to.hideSubmenu();
      }
    });
  }

  TextStyle get _menuTextStyle => const TextStyle(color: Colors.white, fontSize: 12);
}
