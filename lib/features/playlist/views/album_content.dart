import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/utils/local_storage/rp_local_storage.dart';

import '../controller/album_content_controller.dart';

class AlbumContent extends StatelessWidget {
  const AlbumContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (!AlbumContentController.to.canNavigateBack.value) {
            return const SizedBox.shrink();
          }

          return GestureDetector(
            onTap: AlbumContentController.to.navigateBack,
            child: Container(
              padding: const EdgeInsets.only(left: 7),
              child: const Row(
                children: [
                  Icon(
                    Icons.folder,
                    color: Colors.amber,
                    size: 17,
                  ),
                  SizedBox(width: 5),
                  Text("..."),
                ],
              ),
            ),
          );
        }),
        const Expanded(child: RpAlbumItem())
      ],
    );
  }
}

class RpAlbumItem extends StatelessWidget {
  const RpAlbumItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
          itemCount: AlbumContentController.to.currentContent.length,
          itemBuilder: (context, index) {
            final item = AlbumContentController.to.currentContent[index];

            return GestureDetector(
              onTap: () => AlbumContentController.to.handleItemOnTap(item),
              child: Container(
                padding: const EdgeInsets.only(left: 7),
                child: Row(
                  children: [
                    Icon(
                      item.isDirectory ? Icons.folder : Icons.video_file,
                      color: item.isDirectory ? Colors.amber : Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 5),

                    /// title
                    Text(item.name,
                        style: Theme.of(context).textTheme.bodySmall),
                    const Spacer(),

                    /// video duration
                    const Text("00:24:56")
                  ],
                ),
              ),
            );
          });
    });
  }
}
