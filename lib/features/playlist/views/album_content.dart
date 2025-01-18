import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              color: Colors.transparent,
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
            ),
          );
        }),
        const Expanded(child: RpAlbumItems())
      ],
    );
  }
}

class RpAlbumItems extends StatelessWidget {
  const RpAlbumItems({
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
                      size: 15,
                    ),
                    const SizedBox(width: 5),

                    /// title
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),

                    /// video duration
                    // const Text("00:24:56")
                  ],
                ),
              ),
            );
          });
    });
  }
}
