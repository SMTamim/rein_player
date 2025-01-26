import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';

import '../../../utils/constants/rp_colors.dart';

class RpAddNewPlaylistButton extends StatelessWidget {
  const RpAddNewPlaylistButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: PlaylistController.to.showAddPlaylistModal,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
            horizontal: 23, vertical: 13),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            left: BorderSide(
                width: 1, color: RpColors.black),
            bottom: BorderSide(
                width: 1, color: RpColors.black),
          ),
        ),
        child: const Center(
          child: Icon(Iconsax.add, size: 16,)
        ),
      ),
    );
  }
}
