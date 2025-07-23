import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytdl/core/app_theme.dart';
import 'package:ytdl/model/config.dart';
import 'package:ytdl/model/providers/search_filter_provider.dart';
import 'package:ytdl/model/providers/search_query_provider.dart';
import 'package:ytdl/view/home_page/home_page.dart';
import 'package:ytdl/model/providers/playlist_provider.dart';
import 'package:ytdl/model/providers/search_result_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appPath = await Config.fetchConfigPath();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => AppDir(appPath)),
        Provider(create: (context) => AudioPlayer()),
        Provider(create: (context) => OverlayPortalController()),
        ChangeNotifierProvider(create: (context) => SearchQueryProvider()),
        ChangeNotifierProvider(create: (context) => SearchFilterProvider()),
        ChangeNotifierProvider(create: (context) => SearchResultProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ytdl',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
