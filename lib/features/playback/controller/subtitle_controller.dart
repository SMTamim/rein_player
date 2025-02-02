import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rein_player/core/video_player.dart';
import 'package:rein_player/features/settings/controller/settings_controller.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

class SubtitleController extends GetxController {
  static SubtitleController get to => Get.find();

  final storage = RpLocalStorage();

  final player = VideoPlayer.getInstance.player;

  RxBool isSubtitleEnabled = false.obs;
  String currentSubtitleContent = "";

  /// load subtitle from file system
  void loadSubtitle() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['srt', 'vtt'],
      allowMultiple: false,
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      final file = File(filePath);
      final content = await file.readAsString();
      log(content);

      final extension = filePath.split(".").last.toLowerCase();
      if(extension == "srt" || extension == "vtt") {
        currentSubtitleContent = content;
        isSubtitleEnabled.value = true;
        await player.setSubtitleTrack(SubtitleTrack.data(content));
      }else{
        Get.snackbar('Error', 'Only SRT and VTT are supported',
            snackPosition: SnackPosition.TOP, maxWidth: 500);
      }
    }
  }

  Future<void> disableSubtitle() async {
    await player.setSubtitleTrack(SubtitleTrack.no());
  }

  /// toggle subtitle
  void toggleSubtitle() async {
    if(isSubtitleEnabled.value){
      isSubtitleEnabled.value = false;
      await disableSubtitle();
    }else {
      if(currentSubtitleContent.isNotEmpty){
        isSubtitleEnabled.value = true;
        await player.setSubtitleTrack(SubtitleTrack.data(currentSubtitleContent));
      }
    }
    final settings  = SettingsController.to.settings;
    settings.isSubtitleEnabled = isSubtitleEnabled.value;
    await storage.saveData(RpKeysConstants.settingsKey, settings.toJson());
  }
}
