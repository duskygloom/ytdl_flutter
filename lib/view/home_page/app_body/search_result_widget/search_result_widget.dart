import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/core/data_classes/artist_info.dart';
import 'package:ytdl/core/data_classes/basic_info.dart';
import 'package:ytdl/core/data_classes/media_info.dart';
import 'package:ytdl/core/data_classes/song_info.dart';
import 'package:ytdl/core/data_classes/video_info.dart';
import 'package:ytdl/model/providers/playlist_provider.dart';
import 'package:ytdl/view/home_page/app_body/search_result_widget/artist_tile.dart';
import 'package:ytdl/view/home_page/app_body/search_result_widget/song_tile.dart';
import 'package:ytdl/view/home_page/app_body/search_result_widget/video_tile.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key, required this.result});

  final BasicInfo result;

  @override
  Widget build(BuildContext context) {
    final Widget child;

    switch (result.resultType) {
      case 'song':
        child = SongTile(result: SongInfo.fromBasic(result));
        break;
      case 'video':
        child = VideoTile(result: VideoInfo.fromBasic(result));
        break;
      case 'artist':
        child = ArtistTile(result: ArtistInfo.fromBasic(result));
        break;
      default:
        child = ListTile(title: Text('Unimplemented'));
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          final provider = context.read<PlaylistProvider>();
          if (result.isMedia()) {
            provider.appendSong(MediaInfo.fromBasic(result));
          }
        },
        child: child,
      ),
    );
  }
}
