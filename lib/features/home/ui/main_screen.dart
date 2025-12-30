import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lunch_decider/core/theme/app_theme.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6), // Toss-like light grey background
      body: Stack(
        children: [
          navigationShell, // The Content
          
          // Floating Bottom Navigation Bar
          Positioned(
            left: 24,
            right: 24,
            bottom: 34,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home_filled, '홈', 0),
                  _buildNavItem(Icons.place, '내 주변', 1),
                  _buildNavItem(Icons.gamepad, '게임', 2),
                  _buildNavItem(Icons.history, '기록', 3),
                  _buildNavItem(Icons.menu, '전체', 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = navigationShell.currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        navigationShell.goBranch(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, 
            color: isSelected ? const Color(0xFF1B1D1F) : const Color(0xFFB1B8C0),
            size: 24
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isSelected ? const Color(0xFF1B1D1F) : const Color(0xFFB1B8C0),
            ),
          ),
        ],
      ),
    );
  }
}
