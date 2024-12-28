import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/utils/device/rp_device_utils.dart';

class RpPlaylistSideBar extends StatelessWidget {
  const RpPlaylistSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final playlistController = Get.put(PlaylistController());

    return Obx(() {
      return SizedBox(
        width: playlistController.playlistWindowWidth.value,
        child: Text("play list"),
      );
    });
  }
}
