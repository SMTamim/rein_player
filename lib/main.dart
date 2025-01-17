import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/core/video_player.dart';
import 'package:window_manager/window_manager.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await windowManager.ensureInitialized();
  VideoPlayer.getInstance.ensureInitialized();

  runApp(RpApp());

  doWhenWindowReady((){
    windowManager.setSize(RpSizes.initialAppWindowSize);
    windowManager.setMinimumSize(RpSizes.initialAppWindowSize);
    appWindow.alignment = Alignment.center;
    windowManager.show();
  });
}



