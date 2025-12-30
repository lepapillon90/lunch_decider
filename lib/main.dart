import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  
  // Kakao Map Initialization
  // This plugin is WebView-based and requires the JavaScript Key for all platforms
  AuthRepository.initialize(appKey: 'e232b750f214ced5524f480a11662743');
  
  runApp(const ProviderScope(child: LunchDeciderApp()));
}

class LunchDeciderApp extends StatelessWidget {
  const LunchDeciderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '점심결정사',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
