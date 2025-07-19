import 'package:desktop_drop/desktop_drop.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/player_frame/controller/window_controller.dart';
import 'package:rein_player/features/settings/controller/settings_controller.dart';
import 'package:rein_player/utils/constants/rp_enums.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

import '../../settings/models/settings.dart';

class PlaylistTypeController extends GetxController {
  static PlaylistTypeController get to => Get.find();
  final storage = RpLocalStorage();

  Rx<PlaylistType> playlistType = PlaylistType.defaultPlaylistType.obs;
  RxList<DropItem?> dropItems = <DropItem?>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final settingsData = await storage.readData(RpKeysConstants.settingsKey);
    if (settingsData != null) {
      final settings = Settings.fromJson((settingsData));
      playlistType.value = settings.playlistType;
    }
  }

  /// change PlaylistType
  void changePlaylistType(PlaylistType playlistType) async {
    this.playlistType.value = playlistType;

    /// if playlist type changed midway then it should handle the new change
    if (dropItems.isNotEmpty) {
      final nonNullItems = dropItems.whereType<DropItem>().toList();
      if (nonNullItems.isNotEmpty) {
        WindowController.to.onWindowDrop(nonNullItems);
      }
    }

    final settings = SettingsController.to.settings;
    settings.playlistType = playlistType;
    await storage.saveData(RpKeysConstants.settingsKey, settings.toJson());
  }
}
