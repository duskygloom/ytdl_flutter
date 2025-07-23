// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/core/data_classes/info_type.dart';

class Config {
  static const filename = 'config.json';
  static const defaultConfig = {
    'apiUrl': 'localhost',
    'resultCount': 5,
    'audioQlt': 'none',
    'audioExt': 'm4a',
    'videoQlt': 'none',
    'videoExt': 'mp4',
  };
  static final fields = defaultConfig.keys.toList();

  final String configPath;

  const Config(this.configPath);

  static Config fromContext(BuildContext context, {bool listen = true}) {
    return Config(_pathFromContext(context, listen: listen));
  }

  static bool _isInfoSufficient(InfoType info) {
    for (final field in fields) {
      if (!info.containsKey(field)) return false;
    }
    return true;
  }

  static Future<String> fetchConfigPath() async {
    final appDir = await getApplicationSupportDirectory();
    return path.join(appDir.path, filename);
  }

  static String _pathFromContext(BuildContext context, {bool listen = true}) {
    return Provider.of<AppDir>(context, listen: listen).path;
  }

  dynamic _getConfig(String field) {
    final file = File(configPath);
    if (!file.existsSync()) file.createSync(recursive: true);

    try {
      final readJson = jsonDecode(file.readAsStringSync());
      if (_isInfoSufficient(readJson)) {
        return readJson[field];
      }
    } catch (e) {}
    return defaultConfig[field]!;
  }

  void _setConfig(String field, dynamic value) {
    final file = File(configPath);
    if (!file.existsSync()) file.createSync(recursive: true);

    try {
      final InfoType readJson = jsonDecode(file.readAsStringSync());
      if (_isInfoSufficient(readJson)) {
        readJson[field] = value;
        file.writeAsStringSync(jsonEncode(readJson), flush: true);
        return;
      }
    } catch (e) {}
    final writeJson = Map.from(defaultConfig);
    writeJson[field] = value;
    file.writeAsStringSync(jsonEncode(writeJson), flush: true);
  }

  String get apiUrl => _getConfig(fields[0]) as String;
  int get resultCount => _getConfig(fields[1]) as int;
  String get audioQlt => _getConfig(fields[2]) as String;
  String get audioExt => _getConfig(fields[3]) as String;
  String get videoQlt => _getConfig(fields[4]) as String;
  String get videoExt => _getConfig(fields[5]) as String;

  set apiUrl(String url) => _setConfig(fields[0], url);
  set resultCount(int count) => _setConfig(fields[1], count);
  set audioQlt(String value) => _setConfig(fields[2], value);
  set audioExt(String value) => _setConfig(fields[3], value);
  set videoQlt(String value) => _setConfig(fields[4], value);
  set videoExt(String value) => _setConfig(fields[5], value);
}

class AppDir {
  const AppDir(this.path);
  final String path;
}
