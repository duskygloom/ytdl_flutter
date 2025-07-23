import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/core/data_classes/media_info.dart';
import 'package:ytdl/model/api.dart';
import 'package:ytdl/model/providers/playlist_provider.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, songInfo, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Provider.of<OverlayPortalController>(
                context,
                listen: false,
              ).hide();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: songInfo.current == null ? null : Player(info: songInfo.current!),
      ),
    );
  }
}

class Player extends StatefulWidget {
  const Player({super.key, required this.info});

  final MediaInfo info;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final player = AudioPlayer();
  var sourceUrl = '';
  var sourceLength = 0;
  var playing = false;
  var searching = false;
  var downloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    player.dispose().then((_) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const maxImageSize = 500;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final imageWidth = screenWidth.clamp(0, maxImageSize).toDouble() - 20;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                widget.info.thumbnail500,
                width: imageWidth,
                height: imageWidth,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    searching = true;
                  });
                  final api = Api.fromContext(context, listen: false);
                  final streams = await api.getStreams(widget.info.url);
                  sourceUrl = streams.first.url;
                  sourceLength = streams.first.filesize;
                  for (final stream in streams) {
                    if (stream.ext == 'm4a') {
                      sourceUrl = stream.url;
                      sourceLength = stream.filesize;
                      break;
                    }
                  }
                  player.setSourceUrl(sourceUrl);
                  setState(() {
                    searching = false;
                  });
                },
                icon: searching
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Icon(Symbols.search),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Symbols.chevron_backward),
              ),
              IconButton(
                onPressed: () async {
                  if (playing) {
                    await player.pause();
                  } else {
                    await player.resume();
                  }
                  setState(() {
                    playing = !playing;
                  });
                },
                icon: Icon(playing ? Symbols.pause : Symbols.play_arrow),
              ),
              IconButton(onPressed: () {}, icon: Icon(Symbols.chevron_forward)),
              IconButton(
                onPressed: () async {
                  await player.stop();
                  setState(() {
                    playing = false;
                  });
                },
                icon: Icon(Symbols.stop),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
