import 'package:flutter/material.dart';
import 'package:ytdl/core/app_theme.dart';
import 'package:ytdl/core/data_classes/media_info.dart';
import 'package:ytdl/view/core_view/square_thumbnail.dart';

class MiniPlayerInfo {
  final MediaInfo mediaInfo;

  const MiniPlayerInfo(this.mediaInfo);

  List<Widget> childrenOf(BuildContext context) => [
    SquareThumbnail(url: mediaInfo.thumbnail50, width: 48),
    SizedBox(width: 12),
    Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mediaInfo.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextTheme.of(
              context,
            ).titleMedium?.copyWith(color: colorSchemeOf(context).onSurface),
          ),
          Text(
            mediaInfo.artistStr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextTheme.of(context).bodyMedium?.copyWith(
              color: colorSchemeOf(context).onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
  ];
}
