import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

import 'package:rein_player/utils/constants/rp_sizes.dart';



class RpAddPlaylistModal extends StatelessWidget {
  const RpAddPlaylistModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// title and close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Add New Playlist',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    PlaylistController.to.clearForm();
                    Get.back();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Playlist Name Field
            GestureDetector(
              onTap: () {
                PlaylistController.to.playlistNameFocusNode.requestFocus();
              },
              child: SizedBox(
                height: RpSizes.textInputSize,
                child: TextField(
                  controller: PlaylistController.to.playlistNameController,
                  style: const TextStyle(color: Colors.white),
                  focusNode: PlaylistController.to.playlistNameFocusNode,
                  decoration:  const InputDecoration(
                    labelText: 'Playlist Name',
                    labelStyle: TextStyle(color: RpColors.black_600, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: RpColors.black_500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Folder Selection
            Row(
              children: [
                Expanded(
                  child: Obx(() => Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: RpColors.black_500),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      PlaylistController.to.selectedFolderPath.value.isEmpty
                          ? 'No folder selected'
                          : PlaylistController.to.selectedFolderPath.value,
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: PlaylistController.to.pickFolder,
                  icon: Icon(Icons.folder_open),
                  label: Text('Browse'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RpColors.black_500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    PlaylistController.to.clearForm();
                    Get.back();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: PlaylistController.to.createNewPlaylist,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RpColors.accent,
                  ),
                  child: Text('Create Playlist', style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
