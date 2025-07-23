import 'package:flutter/material.dart';
import 'package:ytdl/view/home_page/top_bar/filter_row.dart';
import 'package:ytdl/view/home_page/top_bar/search_row.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchRow(),
        FilterRow(),
      ],
    );
  }
}
