import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../restaurant/domain/restaurant_model.dart';
import '../../map/ui/map_view.dart';
import '../../map/logic/map_controller.dart';
import '../../../core/theme/app_theme.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1B1D1F),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.star_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4F6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      restaurant.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4E5968),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1D1F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Color(0xFF8B95A1)),
                      const SizedBox(width: 4),
                      Text(
                        '내 위치에서 ${restaurant.distance}m',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8B95A1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _buildActionButton(
                    icon: Icons.phone, 
                    label: '전화', 
                    isActive: restaurant.phone != null,
                    onTap: () {
                      if (restaurant.phone != null) {
                        ref.read(mapControllerProvider.notifier).launchDialer(restaurant.phone!);
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    icon: Icons.directions, 
                    label: '출발',
                    onTap: () {
                      ref.read(mapControllerProvider.notifier).launchNavigation(
                        lat: restaurant.latitude,
                        lng: restaurant.longitude,
                        name: restaurant.name,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    icon: Icons.chat_bubble_outline, 
                    label: '후기',
                    onTap: () {
                      if (restaurant.placeUrl != null) {
                        ref.read(mapControllerProvider.notifier).launchUrlInBrowser(restaurant.placeUrl!);
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Divider(thickness: 8, color: Color(0xFFF2F4F6)),

            // Map Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '위치',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1D1F),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF2F4F6)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: MapView(
                      latitude: restaurant.latitude,
                      longitude: restaurant.longitude,
                      restaurantName: restaurant.floor != null 
                          ? '${restaurant.name} ${restaurant.floor}' 
                          : restaurant.name,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    restaurant.address,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4E5968),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 8, color: Color(0xFFF2F4F6)),

            // Info Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text(
                    '정보',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1D1F),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (restaurant.floor != null) ...[
                    _InfoRow(icon: Icons.layers, label: '층수', value: restaurant.floor!),
                    const SizedBox(height: 16),
                  ],
                  _InfoRow(
                    icon: Icons.access_time, 
                    label: '영업 시간', 
                    value: '상세 정보에서 확인',
                    trailing: restaurant.placeUrl != null ? IconButton(
                      icon: const Icon(Icons.open_in_new, size: 16),
                      onPressed: () => ref.read(mapControllerProvider.notifier).launchUrlInBrowser(restaurant.placeUrl!),
                    ) : null,
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.phone_android, 
                    label: '연락처', 
                    value: restaurant.phone ?? '정보 없음',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 34),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            ref.read(mapControllerProvider.notifier).launchNavigation(
              lat: restaurant.latitude,
              lng: restaurant.longitude,
              name: restaurant.name,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B1D1F),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Text(
            '길찾기',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon, 
    required String label, 
    VoidCallback? onTap,
    bool isActive = true,
  }) {
    return Expanded(
      child: InkWell(
        onTap: isActive ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFF2F4F6) : const Color(0xFFF2F4F6).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon, 
                color: isActive ? const Color(0xFF4E5968) : const Color(0xFFB1B8C0), 
                size: 20
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? const Color(0xFF4E5968) : const Color(0xFFB1B8C0),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: const Color(0xFFB1B8C0)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8B95A1),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4E5968),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
