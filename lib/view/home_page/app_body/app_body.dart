import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/model/providers/search_result_provider.dart';
import 'package:ytdl/view/home_page/app_body/search_result_widget/search_result_widget.dart';
import 'package:ytdl/view/home_page/app_body/tweak_display_row.dart';

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchResultProvider>(
      builder: (context, provider, child) {
        final results = provider.results;
        return Expanded(
          child: ListView(
            children:
                <Widget>[TweakDisplayRow()] +
                List.generate(
                  results.length,
                  (index) => SearchResultWidget(result: results[index]),
                ),
          ),
        );
      },
    );
  }
}
