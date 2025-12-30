import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  
  // Kakao Map Initialization
  // TODO: Replace 'YOUR_JAVASCRIPT_KEY' with your actual Kakao JavaScript Key
  // Note: This is different from the REST API Key used in repositories.
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
