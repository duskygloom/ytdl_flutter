import 'package:flutter/material.dart';
import 'package:ytdl/core/data_classes/media_info.dart';

class PlaylistProvider extends ChangeNotifier {
  // stores info : stream url
  final _playlist = <MediaInfo, String>{};
  int _current = 0;

  MediaInfo? get current => _current < 0 || _current >= _playlist.length
      ? null
      : _playlist.keys.elementAt(_current);

  String get currentUrl => _playlist[current] ?? '';

  set currentUrl(String url) {
    if (_playlist.containsKey(current)) _playlist[current!] = url;
  }

  /// @description
  /// Updates the player to play the next song.
  /// Returns true if song has been changed.
  /// Else false if could not increment song.
  bool gotoNext() {
    if (_current < _playlist.length - 1) {
      _current++;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool gotoPrev() {
    if (_current > 0) {
      _current--;
      notifyListeners();
      return true;
    }
    return false;
  }

  void appendSong(MediaInfo songInfo, {String url = ''}) {
    _playlist[songInfo] = url;
    notifyListeners();
  }
}
