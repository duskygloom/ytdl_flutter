import 'package:ytdl/core/data_classes/info_type.dart';

class StreamInfo {
  static const fields = {
    'filesize',
    'format_note',
    'fps',
    'height',
    'width',
    'quality',
    'url',
    'ext',
    'vcodec',
    'acodec',
  };

  static bool isInfoSufficient(InfoType info) {
    for (final field in fields) {
      if (!info.containsKey(field)) return false;
    }
    return true;
  }

  final InfoType original;

  StreamInfo(this.original) {
    assert(isInfoSufficient(original));
  }

  int get filesize => original['filesize'] ?? 0;
  String get formatNote => original['format_note']!;
  int get fps => original['fps']!;
  int get width => original['width']!;
  int get height => original['height']!;
  int get quality => original['quality']!;
  String get url => original['url']!;
  String get ext => original['ext']!;
  String get vcodec => original['vcodec']!;
  String get acodec => original['acodec']!;
}
