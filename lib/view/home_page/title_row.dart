import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:ytdl/view/settings_page/settings_page.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  icon: CircleAvatar(backgroundColor: Colors.red),
                ),
                Text('yt-dl', style: Theme.of(context).appBarTheme.titleTextStyle),
              ],
            ),
            Row(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [IconButton(onPressed: () {}, icon: Icon(Symbols.add))],
            ),
          ],
        ),
      ),
    );
  }
}
