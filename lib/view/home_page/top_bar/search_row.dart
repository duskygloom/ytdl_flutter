import 'package:flutter/material.dart';
import 'package:ytdl/view/home_page/top_bar/search_field.dart';

class SearchRow extends StatelessWidget {
  const SearchRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: SearchField(),
    );
  }
}
