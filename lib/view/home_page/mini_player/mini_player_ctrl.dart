import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:ytdl/core/app_theme.dart';
import 'package:ytdl/model/providers/playlist_provider.dart';
import 'package:ytdl/view/core_view/spinner20.dart';

typedef CtrlCallback = Future<void> Function(PlaylistProvider);

class MiniPlayerCtrl {
  const MiniPlayerCtrl(
    this.play,
    this.pause,
    this.refresh,
    this.playlist,
    this.playing,
    this.searching,
  );

  final bool playing;
  final bool searching;
  final PlaylistProvider playlist;
  final CtrlCallback pause;
  final CtrlCallback play;
  final CtrlCallback refresh;

  List<Widget> childrenOf(BuildContext context) {
    final dimColor = colorSchemeOf(context).onSurfaceVariant.withAlpha(150);

    final Widget playIcon;
    if (searching) {
      playIcon = Spinner20();
    } else if (playlist.currentUrl.isEmpty) {
      playIcon = Icon(Symbols.play_arrow, color: dimColor);
    } else if (playing) {
      playIcon = Icon(Symbols.pause);
    } else {
      playIcon = Icon(Symbols.play_arrow);
    }

    return [
      SizedBox(width: 8),
      IconButton(
        onPressed: () async {
          await pause(playlist);
          playlist.gotoPrev();
        },
        icon: Icon(Symbols.chevron_backward),
      ),
      IconButton(
        onPressed: () async {
          if (playlist.currentUrl.isEmpty) {
            await refresh(playlist);
            await play(playlist);
          } else if (playing) {
            await pause(playlist);
          } else {
            await play(playlist);
          }
        },
        icon: playIcon,
      ),
      IconButton(
        onPressed: () async {
          await pause(playlist);
          playlist.gotoNext();
        },
        icon: Icon(Symbols.chevron_forward),
      ),
    ];
  }
}
