import 'package:flutter/material.dart';

import 'package:rein_player/features/settings/controller/menu_controller.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  MenuItem({required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        MainMenuController.to.hideMenu();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.black87,
          border: Border(bottom: BorderSide(color: Colors.white30)),
        ),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}