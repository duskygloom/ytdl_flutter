import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:ytdl/core/data_classes/artist_info.dart';
import 'package:ytdl/view/core_view/square_thumbnail.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({super.key, required this.result});

  final ArtistInfo result;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(result.artist, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text('Artist'),
      leading: CircularThumbnail(
        url: result.thumbnail50,
        width: 48, // 48 is the height of leading widget (maybe)
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Symbols.more_vert)),
    );
  }
}
