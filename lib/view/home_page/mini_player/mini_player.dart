import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/core/app_theme.dart';
import 'package:ytdl/core/data_classes/song_info.dart';
import 'package:ytdl/core/data_classes/stream_info.dart';
import 'package:ytdl/core/data_classes/video_info.dart';
import 'package:ytdl/model/api.dart';
import 'package:ytdl/model/config.dart';
import 'package:ytdl/model/providers/playlist_provider.dart';
import 'package:ytdl/view/home_page/mini_player/mini_player_ctrl.dart';
import 'package:ytdl/view/home_page/mini_player/mini_player_info.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  var playing = false;
  var searching = false;
  var downloading = false;
  var seekbar = 0.0;
  var totalSeconds = 1;

  late AudioPlayer player;
  var subscriptions = <StreamSubscription<void>>[];

  @override
  void initState() {
    super.initState();
    player = Provider.of<AudioPlayer>(context, listen: false);
    if (player.state == PlayerState.playing) {
      playing = true;
      player.getDuration().then((dur) {
        totalSeconds = dur?.inSeconds ?? 0;
      });
    }
    // player events
    subscriptions.addAll([
      player.onPlayerComplete.listen((_) {
        setState(() => playing = false);
      }),
      player.onDurationChanged.listen((dur) {
        setState(() => totalSeconds = dur.inSeconds < 1 ? 1 : dur.inSeconds);
      }),
      player.onPositionChanged.listen((dur) {
        setState(() => seekbar = dur.inSeconds / totalSeconds);
      }),
    ]);
  }

  @override
  void dispose() {
    for (final subscription in subscriptions) {
      subscription.cancel().then((_) {});
    }
    subscriptions.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playlist = context.watch<PlaylistProvider>();

    final leadingChildren = playlist.current == null
        ? <Widget>[Spacer()]
        : MiniPlayerInfo(playlist.current!).childrenOf(context);

    final trailingChildren = MiniPlayerCtrl(
      _play,
      _pause,
      _refresh,
      playlist,
      playing,
      searching,
    ).childrenOf(context);

    return Container(
      height: scaledSizeOf(context, 70),
      margin: EdgeInsets.all(8),
      child: Material(
        elevation: 8,
        color: colorSchemeOf(context).surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // children: [Expanded(child: leading), trailing],
                  children: leadingChildren + trailingChildren,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8),
                value: seekbar,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh(PlaylistProvider playlist) async {
    setState(() => searching = true);
    if (playlist.current != null) {
      final api = Api.fromContext(context, listen: false);
      final config = Config.fromContext(context, listen: false);
      // stream info from config and filter
      final List<StreamInfo> streams;
      if (playlist.current!.resultType == 'song') {
        streams = await api.getStreams(
          SongInfo.fromMedia(playlist.current!).url,
          ext: config.audioExt,
          quality: config.audioQlt,
        );
      } else if (playlist.current!.resultType == 'video') {
        streams = await api.getStreams(
          VideoInfo.fromMedia(playlist.current!).url,
          // change to video ext and qlt after video playback is stable
          ext: config.audioExt,
          quality: config.audioQlt,
        );
      } else {
        streams = await api.getStreams(playlist.current!.url);
      }
      // set current url
      if (streams.isNotEmpty) playlist.currentUrl = streams.first.url;
    }
    setState(() => searching = false);
  }

  Future<void> _play(PlaylistProvider playlist) async {
    if (player.source != UrlSource(playlist.currentUrl)) {
      await player.play(UrlSource(playlist.currentUrl));
    } else {
      await player.resume();
    }
    setState(() => playing = true);
  }

  Future<void> _pause(PlaylistProvider playlist) async {
    await player.pause();
    setState(() => playing = false);
  }
}
