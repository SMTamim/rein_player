import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class RpWindowFrame extends StatelessWidget {
  const RpWindowFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(child: MoveWindow(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Rein Player"),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}


class LeftSide extends StatelessWidget {
  const LeftSide({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: Color(0xFF2B2B2B),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.menu, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Menu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}