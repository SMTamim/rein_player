import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/utils/constants/rp_keys.dart';

import '../../../utils/constants/rp_colors.dart';
import 'add_new_playlist_button.dart';

class RpAllAlbums extends StatelessWidget {
  const RpAllAlbums({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Obx(
        () {
          return ListView.builder(
            itemCount: AlbumController.to.albums.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              if (index == AlbumController.to.albums.length) {
                return const RpAddNewPlaylistButton();
              }

              final album = AlbumController.to.albums[index];
              return Obx(
                () => Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      left: index == 0
                          ? BorderSide.none
                          : const BorderSide(
                              width: 1,
                              color: RpColors.black,
                            ),
                      bottom:
                          AlbumController.to.selectedAlbumIndex.value == index
                              ? BorderSide.none
                              : const BorderSide(
                                  width: 1,
                                  color: RpColors.black,
                                ),
                    ),
                  ),
                  child: Row(
                     mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: [
                      /// album name
                      InkWell(
                        onTap: () =>
                            AlbumController.to.updateSelectedAlbumIndex(index),
                        mouseCursor: SystemMouseCursors.click,
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              album.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: RpColors.black_300),
                            ),
                          ),
                        ),
                      ),

                      if(album.id != RpKeysConstants.defaultAlbumKey)
                      const SizedBox(width: 12),

                      if(album.id != RpKeysConstants.defaultAlbumKey)
                      InkWell(
                        onTap: () => AlbumController.to.removeAlbumFromList(album),
                        mouseCursor: SystemMouseCursors.click,
                        child: const Icon(Icons.close, size: 14,),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
