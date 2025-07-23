import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/core/app_theme.dart';
import 'package:ytdl/model/providers/search_filter_provider.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = SearchFilterProvider.filters;

    return Container(
      height: scaledSizeOf(context, 54),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final searchFilter = context.watch<SearchFilterProvider>();
          final selectedButtonStyle = ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary.withAlpha(100),
            ),
          );
          return TextButton(
            style: searchFilter.filter == filters[index]
                ? selectedButtonStyle
                : null,
            onPressed: () {
              final searchFilter = context.read<SearchFilterProvider>();
              searchFilter.updateFilter(filters[index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(filters[index]),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 6),
        itemCount: filters.length,
      ),
    );
  }
}
