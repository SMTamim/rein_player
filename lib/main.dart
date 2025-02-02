import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/core/video_player.dart';
import 'package:window_manager/window_manager.dart';
import 'package:rein_player/utils/constants/rp_sizes.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await GetStorage.init();
  await windowManager.ensureInitialized();
  VideoPlayer.getInstance.ensureInitialized();

  doWhenWindowReady(() {
    windowManager.setSize(RpSizes.initialAppWindowSize);
    windowManager.setMinimumSize(RpSizes.initialAppWindowSize);
    appWindow.alignment = Alignment.center;
    windowManager.show();
  });
  runApp(RpApp());
}
