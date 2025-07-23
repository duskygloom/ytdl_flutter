import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/model/api.dart';
import 'package:ytdl/model/config.dart';
import 'package:ytdl/model/providers/search_filter_provider.dart';
import 'package:ytdl/model/providers/search_query_provider.dart';
import 'package:ytdl/model/providers/search_result_provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final query = context.read<SearchQueryProvider>().query;
    final controller = TextEditingController(text: query);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Symbols.search),
        hintText: 'What do you want to listen today?',
        filled: true,
        suffixIcon: loading ? Icon(Symbols.more_horiz) : null,
      ),
      onChanged: (value) {
        context.read<SearchQueryProvider>().updateQuery(value);
      },
      onSubmitted: (value) async {
        setState(() => loading = true);
        final api = Api.fromContext(context, listen: false);
        final config = Config.fromContext(context, listen: false);
        final searchFilter = context.read<SearchFilterProvider>();
        final result = await api.search(
          value,
          searchFilter.filter,
          count: config.resultCount,
        );
        if (context.mounted) {
          final searchResult = context.read<SearchResultProvider>();
          searchResult.updateResult(result);
        }
        setState(() => loading = false);
      },
    );
  }
}
