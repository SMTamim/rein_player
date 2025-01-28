import 'package:flutter/material.dart';

import 'menu_item.dart';


class Submenu extends StatelessWidget {
  final List<MenuItem> items;

  Submenu({required this.items});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title"),
          ...items
        ],
      ),
    );
  }
}