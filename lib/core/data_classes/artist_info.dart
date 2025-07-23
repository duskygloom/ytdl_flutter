import 'package:ytdl/core/data_classes/basic_info.dart';
import 'package:ytdl/core/data_classes/info_type.dart';

class ArtistInfo extends BasicInfo {
  static const fields = {
    "browseId",
        "shuffleId",
        "radioId",
        "resultType",
        "artist",
        "thumbnails",
  };

  static bool isInfoSufficient(InfoType info) {
    for (final field in fields) {
      if (!info.containsKey(field)) return false;
    }
    return true;
  }

  ArtistInfo(super.original) {
    assert(isInfoSufficient(original));
  }

  static ArtistInfo fromBasic(BasicInfo info) {
    return ArtistInfo(info.original);
  }

  String get browseId => original['browseId']!;
  String get shuffleId => original['shuffleId']!;
  String get radioId => original['radioId']!;

  String get artist => original['artist']!;

  List<InfoType> get thumbnails {
    List<InfoType> thumbs = [];
    for (final thumb in original['thumbnails']! as List) {
      thumbs.add(thumb as InfoType);
    }
    return thumbs;
  }

  String get browseUrl => 'https://music.youtube.com/channel/$browseId';
  String get shuffleUrl => 'https://music.youtube.com/channel/$shuffleId';
  String get radioUrl => 'https://music.youtube.com/channel/$radioId';

  String _thumbnailOfSize(int width, int height) {
    final String thumb = thumbnails.first['url'];
    final breakPoint = thumb.lastIndexOf('=');
    return thumb
        .replaceFirst(RegExp(r'w\d+'), 'w$width', breakPoint)
        .replaceFirst(RegExp(r'h\d+'), 'h$height', breakPoint);
  }

  String get thumbnail50 => _thumbnailOfSize(50, 50);
  String get thumbnail500 => _thumbnailOfSize(500, 500);
}
