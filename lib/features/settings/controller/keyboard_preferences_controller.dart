import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

class KeyboardPreferencesController extends GetxController {
  static KeyboardPreferencesController get to => Get.find();

  final storage = RpLocalStorage();

  final RxMap<String, LogicalKeyboardKey> keyBindings =
      <String, LogicalKeyboardKey>{}.obs;

  // Default keyboard bindings
  static const Map<String, LogicalKeyboardKey> defaultBindings = {
    'play_pause': LogicalKeyboardKey.space,
    'fullscreen': LogicalKeyboardKey.enter,
    'seek_backward': LogicalKeyboardKey.arrowLeft,
    'seek_forward': LogicalKeyboardKey.arrowRight,
    'big_seek_backward': LogicalKeyboardKey.arrowLeft, // With Shift
    'big_seek_forward': LogicalKeyboardKey.arrowRight, // With Shift
    'volume_up': LogicalKeyboardKey.arrowUp,
    'volume_down': LogicalKeyboardKey.arrowDown,
    'toggle_mute': LogicalKeyboardKey.keyM,
    'toggle_subtitle': LogicalKeyboardKey.keyH,
    'exit_fullscreen': LogicalKeyboardKey.escape,
    'toggle_playlist': LogicalKeyboardKey.keyB, // With Ctrl
    'toggle_developer_log': LogicalKeyboardKey.keyD, // With Ctrl
    'decrease_speed': LogicalKeyboardKey.keyX,
    'increase_speed': LogicalKeyboardKey.keyC,
    'next_track': LogicalKeyboardKey.pageDown,
    'previous_track': LogicalKeyboardKey.pageUp,
  };

  // Action descriptions for UI
  static const Map<String, String> actionDescriptions = {
    'play_pause': 'Play/Pause',
    'fullscreen': 'Enter Fullscreen',
    'seek_backward': 'Seek Backward',
    'seek_forward': 'Seek Forward',
    'big_seek_backward': 'Big Seek Backward',
    'big_seek_forward': 'Big Seek Forward',
    'volume_up': 'Volume Up',
    'volume_down': 'Volume Down',
    'toggle_mute': 'Toggle Mute',
    'toggle_subtitle': 'Toggle Subtitles',
    'exit_fullscreen': 'Exit Fullscreen',
    'toggle_playlist': 'Toggle Playlist',
    'toggle_developer_log': 'Toggle Developer Log',
    'decrease_speed': 'Decrease Playback Speed',
    'increase_speed': 'Increase Playback Speed',
    'next_track': 'Next Track',
    'previous_track': 'Previous Track',
  };

  @override
  void onInit() {
    super.onInit();
    loadKeyBindings();
  }

  Future<void> loadKeyBindings() async {
    try {
      final savedBindings =
          storage.readData<Map>(RpKeysConstants.keyboardBindingsKey);

      if (savedBindings != null) {
        // Convert saved data back to LogicalKeyboardKey objects
        for (String action in defaultBindings.keys) {
          final keyCode = savedBindings[action];
          if (keyCode != null) {
            final key = LogicalKeyboardKey.findKeyByKeyId(keyCode);
            if (key != null) {
              keyBindings[action] = key;
            } else {
              keyBindings[action] = defaultBindings[action]!;
            }
          } else {
            keyBindings[action] = defaultBindings[action]!;
          }
        }
      } else {
        keyBindings.addAll(defaultBindings);
      }
      update();
    } catch (e) {
      keyBindings.addAll(defaultBindings);
      update();
    }
  }

  Future<void> saveKeyBindings() async {
    try {
      final Map<String, int> saveData = {};
      for (String action in keyBindings.keys) {
        saveData[action] = keyBindings[action]!.keyId;
      }
      await storage.saveData(RpKeysConstants.keyboardBindingsKey, saveData);
    } catch (e) {

    }
  }

  Future<void> updateKeyBinding(String action, LogicalKeyboardKey key) async {
    final existingAction = getActionForKey(key);
    if (existingAction != null && existingAction != action) {
      // Swap the keys
      final oldKey = keyBindings[action];
      if (oldKey != null) {
        keyBindings[action] = key;
        keyBindings[existingAction] = oldKey;

        update();

        Get.snackbar(
          'Key Binding Updated',
          'Swapped keys for "${actionDescriptions[action]}" and "${actionDescriptions[existingAction]}"',
          snackPosition: SnackPosition.TOP,
          maxWidth: 500,
        );
      }
    } else {
      keyBindings[action] = key;

      update();

      Get.snackbar(
        'Key Binding Updated',
        '${actionDescriptions[action]} is now assigned to ${getKeyDisplayName(key)}',
        snackPosition: SnackPosition.TOP,
        maxWidth: 500,
      );
    }

    await saveKeyBindings();
  }

  String? getActionForKey(LogicalKeyboardKey key) {
    for (String action in keyBindings.keys) {
      if (keyBindings[action] == key) {
        return action;
      }
    }
    return null;
  }

  Future<void> resetToDefaults() async {
    keyBindings.clear();
    keyBindings.addAll(defaultBindings);

    update();

    await saveKeyBindings();

    Get.snackbar(
      'Reset Complete',
      'Keyboard bindings have been reset to defaults',
      snackPosition: SnackPosition.TOP,
      maxWidth: 500,
    );
  }

  String getKeyDisplayName(LogicalKeyboardKey key) {
    // Handle special keys
    if (key == LogicalKeyboardKey.space) return 'Space';
    if (key == LogicalKeyboardKey.enter) return 'Enter';
    if (key == LogicalKeyboardKey.escape) return 'Escape';
    if (key == LogicalKeyboardKey.arrowUp) return 'Arrow Up';
    if (key == LogicalKeyboardKey.arrowDown) return 'Arrow Down';
    if (key == LogicalKeyboardKey.arrowLeft) return 'Arrow Left';
    if (key == LogicalKeyboardKey.arrowRight) return 'Arrow Right';
    if (key == LogicalKeyboardKey.pageUp) return 'Page Up';
    if (key == LogicalKeyboardKey.pageDown) return 'Page Down';

    // Handle letter keys
    if (key.keyLabel.length == 1) {
      return key.keyLabel.toUpperCase();
    }

    return key.keyLabel;
  }

  LogicalKeyboardKey? getKeyForAction(String action) {
    return keyBindings[action];
  }
}
