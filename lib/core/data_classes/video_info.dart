import 'package:ytdl/core/data_classes/info_type.dart';
import 'package:ytdl/core/data_classes/media_info.dart';

class VideoInfo extends MediaInfo {
  static const fields = {
    "videoId",
    "resultType",
    "title",
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

  VideoInfo(super.original) {
    assert(isInfoSufficient(original));
  }

  static VideoInfo fromMedia(MediaInfo info) {
    return VideoInfo(info.original);
  }
}
