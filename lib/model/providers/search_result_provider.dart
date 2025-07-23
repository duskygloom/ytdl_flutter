import 'package:flutter/material.dart';
import 'package:ytdl/core/data_classes/basic_info.dart';

class SearchResultProvider extends ChangeNotifier {
  List<BasicInfo> _results = [];

  List<BasicInfo> get results => _results;

  void updateResult(List<BasicInfo> results) {
    _results = results;
    notifyListeners();
  }
}
