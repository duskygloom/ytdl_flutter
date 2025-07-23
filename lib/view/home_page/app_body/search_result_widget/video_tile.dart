import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:ytdl/core/data_classes/video_info.dart';
import 'package:ytdl/view/core_view/square_thumbnail.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({super.key, required this.result});

  final VideoInfo result;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(result.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        'Video • ${result.artistStr}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: SquareThumbnail(
        url: result.thumbnail50,
        width: 48, // 48 is the height of leading widget (maybe)
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Symbols.more_vert)),
    );
  }
}
