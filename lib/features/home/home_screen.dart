import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/location_provider.dart';
import '../../features/restaurant/data/nearby_restaurants_provider.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 위치 상태 감지
    final locationAsync = ref.watch(currentLocationProvider);

    // 2. 선택된 카테고리 감지
    final selectedCategory = ref.watch(selectedCategoryProvider);

    // 3. 식당 데이터 감지 (위치 및 카테고리 기반)
    final restaurantsAsync = ref.watch(nearbyRestaurantsProvider(selectedCategory));

    final categories = ['전체', '한식', '중식', '일식', '양식', '카페'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 32, height: 32),
            const SizedBox(width: 8),
            const Text(
              '점심결정사',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1D1F),
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.search, color: Color(0xFFB1B8C0), size: 28),
          SizedBox(width: 16),
          Icon(Icons.notifications_none, color: Color(0xFFB1B8C0), size: 28),
          SizedBox(width: 24),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar removed


            // Location Indicator
            locationAsync.when(
              data: (position) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Color(0xFF2377B8)),
                    const SizedBox(width: 4),
                    Text(
                      '현재 위치: ${position.latitude.toStringAsFixed(3)}, ${position.longitude.toStringAsFixed(3)}',
                      style: const TextStyle(color: Color(0xFF4E5968), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),

            // Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Row(
                children: categories.map((category) {
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                         ref.read(selectedCategoryProvider.notifier).setCategory(category);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF1b1D1F) : const Color(0xFFF2F4F6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF4E5968),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            Expanded(
              child: restaurantsAsync.when(
                data: (restaurants) {
                  if (restaurants.isEmpty) {
                    return const Center(child: Text('주변에 식당이 없습니다.', style: TextStyle(color: Color(0xFF8B95A1))));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 100), // Space for Floating Nav
                    itemCount: restaurants.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, indent: 24, endIndent: 24, color: Color(0xFFF2F4F6)),
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return InkWell(
                        onTap: () => context.push('/map', extra: restaurant),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: const Color(0xFFF2F4F6),
                                child: Text(
                                  restaurant.category.isNotEmpty ? restaurant.category.substring(0, 1) : '?',
                                  style: const TextStyle(color: Color(0xFF4E5968), fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant.name,
                                      style: const TextStyle(
                                        fontSize: 17, 
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1B1D1F)
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${restaurant.category} · ${restaurant.distance}m',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF8B95A1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2377B8).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "선택",
                                  style: TextStyle(
                                    color: Color(0xFF2377B8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (err, stack) => Center(child: Text('오류 발생: $err')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
