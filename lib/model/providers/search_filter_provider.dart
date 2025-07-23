import 'package:flutter/material.dart';

class SearchFilterProvider extends ChangeNotifier {
  static const filters = [
    'All',
    'Songs',
    'Videos',
    'Playlists',
    'Albums',
    'Artists',
  ];

  String _filter = filters.first;

  String get filter => _filter;

  void updateFilter(String filter) {
    if (filters.contains(filter)) {
      _filter = filter;
      notifyListeners();
    }
  }
}
