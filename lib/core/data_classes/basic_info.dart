import 'package:ytdl/core/data_classes/info_type.dart';

class BasicInfo {
  final InfoType original;

  BasicInfo(this.original) {
    assert(original.containsKey('resultType'));
  }

  String get resultType => original['resultType']!;

  bool isMedia() {
    return resultType == 'song' || resultType == 'video';
  }
}
