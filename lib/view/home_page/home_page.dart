import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/core/app_theme.dart';
import 'package:ytdl/view/home_page/app_body/app_body.dart';
import 'package:ytdl/view/home_page/mini_player/mini_player.dart';
import 'package:ytdl/view/home_page/title_row.dart';
import 'package:ytdl/view/home_page/top_bar/top_bar.dart';
import 'package:ytdl/view/player_page/player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final portalKey = UniqueKey();
    final appbarHeight = scaledSizeOf(context, 60.0);

    return OverlayPortal(
      key: portalKey,
      controller: Provider.of<OverlayPortalController>(context),
      overlayChildBuilder: (context) => PlayerPage(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, appbarHeight),
          child: TitleRow(height: appbarHeight),
        ),
        body: Column(children: [TopBar(), AppBody(), MiniPlayer()]),
      ),
    );
  }
}
