import 'package:ytdl/core/data_classes/info_type.dart';
import 'package:ytdl/core/data_classes/media_info.dart';

class SongInfo extends MediaInfo {
  static const fields = {
    "videoId",
    "resultType",
    "title",
    "album",
    "duration_seconds",
    "artists",
    "thumbnails",
    "views",
  };

  static bool isInfoSufficient(InfoType info) {
    for (final field in fields) {
      if (!info.containsKey(field)) return false;
    }
    return true;
  }

  SongInfo(super.original) {
    assert(isInfoSufficient(original));
  }

  static SongInfo fromMedia(MediaInfo info) {
    return SongInfo(info.original);
  }

  InfoType get album => original['album']!;

  @override
  String get url => 'https://music.youtube.com/watch?v=$videoId';
}
