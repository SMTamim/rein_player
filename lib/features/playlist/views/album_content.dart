import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playback/controller/video_and_controls_controller.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

import '../controller/album_content_controller.dart';

class AlbumContent extends StatelessWidget {
  const AlbumContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isHovered = false.obs;

    return Column(
      children: [
        /// folder back navigation
        Obx(() {
          if (!AlbumContentController.to.canNavigateBack.value) {
            return const SizedBox.shrink();
          }

          return GestureDetector(
            onTap: AlbumContentController.to.navigateBack,
            child: MouseRegion(
              onEnter: (_) => isHovered.value = true,
              onExit: (_) => isHovered.value = false,
              cursor: SystemMouseCursors.click,
              child: Obx(() {
                return Container(
                  padding: const EdgeInsets.only(left: 7),
                  color: isHovered.value
                      ? RpColors.gray_900.withOpacity(0.2)
                      : Colors.transparent,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: Colors.amber,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text("..."),
                    ],
                  ),
                );
              }),
            ),
          );
        }),

        /// playlist items
        const Expanded(child: RpAlbumItems()),
      ],
    );
  }
}

class RpAlbumItems extends StatelessWidget {
  const RpAlbumItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: AlbumContentController.to.currentContent.length,
        itemBuilder: (context, index) {
          final media = AlbumContentController.to.currentContent[index];
          final isHovered = false.obs;

          return GestureDetector(
            onDoubleTap: () => AlbumContentController.to.handleItemOnTap(media),
            child: MouseRegion(
              onEnter: (_) => isHovered.value = true,
              onExit: (_) => isHovered.value = false,
              cursor: SystemMouseCursors.click,
              child: Obx(() {
                final isCurrentPlayingMedia =
                    VideoAndControlController.to.currentVideo.value?.location ==
                        media.location;

                return Row(
                  children: [
                    const SizedBox(width: 5),
                    Icon(
                      media.isDirectory ? Icons.folder : Icons.video_file,
                      color: (isCurrentPlayingMedia ||
                              isHovered.value ||
                              media.isDirectory)
                          ? RpColors.accent
                          : Colors.white,
                      size: 15,
                    ),
                    const SizedBox(width: 5),

                    /// Title
                    SizedBox(
                      width: PlaylistController.to.playlistWindowWidth *
                          (media.isDirectory ? 0.8 : 0.7),
                      child: Text(
                        "${index + 1}. ${media.name}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: (isCurrentPlayingMedia || isHovered.value)
                                  ? RpColors.accent
                                  : RpColors.black_300,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Spacer(),

                    /// video duration
                    // const Text("00:24:56")
                  ],
                );
              }),
            ),
          );
        },
      );
    });
  }
}
