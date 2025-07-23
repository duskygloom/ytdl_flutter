import 'package:flutter/material.dart';

class SearchQueryProvider extends ChangeNotifier {
  String _query = '';

  String get query => _query;

  void updateQuery(String query) {
    _query = query;
    notifyListeners();
  }
}
