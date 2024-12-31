import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/playlist/controller/playlist_controller.dart';
import 'package:rein_player/features/playlist/models/playlist_item.dart';
import 'package:rein_player/features/playlist/views/add_new_playlist_button.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';

class RpPlaylistSideBar extends StatelessWidget {
  const RpPlaylistSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<PlaylistItem> playList = [
      PlaylistItem(name: "Default", location: "sdf", id: "5"),
      PlaylistItem(name: "playlist 1", location: "sdf", id: "8")
    ];

    return Obx(() {
      return Container(
        decoration: BoxDecoration(color: RpColors.gray_800),
        width: PlaylistController.to.playlistWindowWidth.value,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /// Browser and playlist selector
            RpBrowserAndPlaylistSelector(),

            /// All playlist
            RpAllPlaylist(playList: playList),

            /// Current playlist files
            Expanded(
                child: Column(
              children: [],
            ),)
          ],
        ),
      );
    });
  }
}

class RpAllPlaylist extends StatelessWidget {
  const RpAllPlaylist({
    super.key,
    required this.playList,
  });

  final List<PlaylistItem> playList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      child: ListView.builder(
          itemCount: playList.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            if (index == playList.length) return RpAddNewPlaylistButton();

            final playlistItem = playList[index];
            return InkWell(
              onTap: () {},
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border(
                    left: index == 0
                        ? BorderSide.none
                        : BorderSide(
                            width: 1,
                            color: RpColors.black,
                          ),
                    bottom: BorderSide(
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

class RpBrowserAndPlaylistSelector extends StatelessWidget {
  const RpBrowserAndPlaylistSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RpColors.gray_900,
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 13),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: RpColors.black),
                  right: BorderSide(width: 0.5, color: RpColors.black),
                  bottom: BorderSide(width: 1, color: RpColors.black),
                ),
              ),
              child: Center(
                child: Text(
                  "Playlist",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: RpColors.black_300),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
