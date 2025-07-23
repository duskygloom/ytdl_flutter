import 'package:ytdl/core/data_classes/basic_info.dart';
import 'package:ytdl/core/data_classes/info_type.dart';

class MediaInfo extends BasicInfo {
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

  MediaInfo(super.original) {
    assert(isInfoSufficient(original));
  }

  static MediaInfo fromBasic(BasicInfo info) {
    return MediaInfo(info.original);
  }

  String get videoId => original['videoId']!;

  String get title => original['title']!;
  Duration get durationSeconds =>
      Duration(seconds: original['duration_seconds']);

  List<InfoType> get artists {
    List<InfoType> results = [];
    for (final artist in original['artists']!) {
      results.add(artist as InfoType);
    }
    return results;
  }

  List<InfoType> get thumbnails {
    List<InfoType> thumbs = [];
    for (final thumb in original['thumbnails']! as List) {
      thumbs.add(thumb as InfoType);
    }
    return thumbs;
  }

  String get views => original['views']!;

  String get url => 'https://youtube.com/watch?v=$videoId';

  String get artistStr {
    final artists = this.artists;
    return List.generate(artists.length, (index) {
      return artists[index]['name'] as String;
    }).join(', ');
  }

  String _thumbnailOfSize(double width, double height) {
    final String thumb = thumbnails.first['url'];
    final breakPoint = thumb.lastIndexOf('=');

    final widthText = width.isInfinite ? '' : 'w${width.toInt()}';
    final heightText = height.isInfinite ? '' : 'h${height.toInt()}';

    return thumb
        .replaceFirst(RegExp(r'w\d+'), widthText, breakPoint)
        .replaceFirst(RegExp(r'h\d+'), heightText, breakPoint);
  }

  String get thumbnail50 => _thumbnailOfSize(double.infinity, 50);
  String get thumbnail500 => _thumbnailOfSize(double.infinity, 500);
}
