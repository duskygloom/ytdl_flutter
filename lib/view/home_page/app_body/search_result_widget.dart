import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/core/data_classes/basic_info.dart';
import 'package:ytdl/core/data_classes/media_info.dart';
import 'package:ytdl/model/providers/playlist_provider.dart';
import 'package:ytdl/view/core_view/square_thumbnail.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key, required this.result});

  final BasicInfo result;

  @override
  Widget build(BuildContext context) {
    final ListTile child;

    switch (result.resultType) {
      case 'song':
      case 'video':
        child = ListTile(
          title: Text(
            MediaInfo.fromBasic(result).title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            MediaInfo.fromBasic(result).artistStr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: SquareThumbnail(
            url: MediaInfo.fromBasic(result).thumbnail50,
            width: 48, // 48 is the height of leading widget (maybe)
          ),
          trailing: IconButton(onPressed: () {}, icon: Icon(Symbols.more_vert)),
        );
        break;
      default:
        child = ListTile();
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
