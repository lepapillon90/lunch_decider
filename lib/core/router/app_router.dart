import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/ui/main_screen.dart'; // Import MainScreen
import '../../features/splash/splash_screen.dart';
import '../../features/game/ui/game_hub_screen.dart';
import '../../features/restaurant/ui/restaurant_detail_screen.dart';
import '../../features/restaurant/domain/restaurant_model.dart';
import '../../features/map/ui/nearby_screen.dart';
import '../../features/history/ui/history_screen.dart';
import '../../features/all/ui/all_screen.dart';
final appRouter = GoRouter(
  initialLocation: '/home', // Start at home
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    
    // Shell Route for Tab Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        
        // Tab 1: Nearby (Map)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/nearby',
              builder: (context, state) => const NearbyScreen(),
            ),
          ],
        ),

        // Tab 2: Game
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/game',
              builder: (context, state) => const GameHubScreen(),
            ),
          ],
        ),

        // Tab 3: History
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              builder: (context, state) => const HistoryScreen(),
            ),
          ],
        ),

        // Tab 4: All
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/all',
              builder: (context, state) => const AllScreen(),
            ),
          ],
        ),
      ],
    ),

    // Restaurant Detail Screen
    GoRoute(
      path: '/map',
      builder: (context, state) {
        final restaurant = state.extra as Restaurant;
        return RestaurantDetailScreen(restaurant: restaurant);
      },
    ),
  ],
);
