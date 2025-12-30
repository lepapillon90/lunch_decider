import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/map_initializer.dart'; // Import map initializer
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeMap(); // Safe initialization
  
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
