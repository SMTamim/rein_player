import 'package:flutter/material.dart';
import 'package:rein_player/features/playlist/controller/album_controller.dart';
import 'package:rein_player/features/playlist/models/album.dart';

import '../../../utils/constants/rp_colors.dart';
import '../models/playlist_item.dart';
import 'add_new_playlist_button.dart';

class RpAllAlbums extends StatelessWidget {
  RpAllAlbums({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      child: ListView.builder(
          itemCount: AlbumController.to.albums.value.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            if (index == AlbumController.to.albums.value.length) return RpAddNewPlaylistButton();

            final playlistItem = AlbumController.to.albums.value[index];
            return GestureDetector(
              onTap: () => AlbumController.to.updateSelectedAlbumIndex(index),
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border(
                    left: index == 0
                        ? BorderSide.none
                        : const BorderSide(
                      width: 1,
                      color: RpColors.black,
                    ),
                    bottom: const BorderSide(
                      width: 1,
                      color: RpColors.black,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    playlistItem.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: RpColors.black_300),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
