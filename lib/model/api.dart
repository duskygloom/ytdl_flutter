import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ytdl/core/data_classes/basic_info.dart';
import 'package:ytdl/core/data_classes/info_type.dart';
import 'package:ytdl/core/data_classes/stream_info.dart';
import 'package:ytdl/model/config.dart';

class Api {
  final String baseurl;
  static const endpoints = {'search': '/api/search', 'streams': '/api/streams'};

  const Api(this.baseurl);

  static Api fromContext(BuildContext context, {bool listen = true}) {
    return Api(_urlFromContext(context, listen: listen));
  }

  static String _urlFromContext(BuildContext context, {bool listen = true}) {
    final config = Config.fromContext(context, listen: listen);
    return config.apiUrl;
  }

  Future<List<BasicInfo>> search(
    String query,
    String filter, {
    int count = 5,
  }) async {
    final uri = Uri.http(baseurl, endpoints['search']!, {
      'query': query,
      'count': count.toString(),
      'filter': filter.toLowerCase(),
    });
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List json = jsonDecode(response.body);
        return List.generate(json.length, (index) {
          final InfoType info = json[index];
          return BasicInfo(info);
        });
      } else {}
      return [];
    } catch (e) {
      if (e is http.ClientException) return [];
      rethrow;
    }
  }

  Future<List<StreamInfo>> getStreams(
    String url, {
    String quality = 'm4a',
    String ext = 'none',
  }) async {
    final uri = Uri.http(baseurl, endpoints['streams']!, {
      'url': url,
      'ext': ext,
      'quality': quality,
    });
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List json = jsonDecode(response.body);
        return List.generate(json.length, (index) {
          final InfoType info = json[index];
          return StreamInfo(info);
        });
      } else {}
      return [];
    } catch (e) {
      if (e is http.ClientException) return [];
      rethrow;
    }
  }
}
