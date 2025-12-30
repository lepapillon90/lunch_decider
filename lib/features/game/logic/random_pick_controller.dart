import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../restaurant/data/nearby_restaurants_provider.dart';
import '../../restaurant/domain/restaurant_model.dart';

// 상태: 선택된 식당 (nullable) - StateProvider 대신 NotifierProvider 사용
class RandomPickNotifier extends Notifier<Restaurant?> {
  @override
  Restaurant? build() => null;

  void setPickedRestaurant(Restaurant? restaurant) {
    state = restaurant;
  }
}

final randomPickProvider = NotifierProvider<RandomPickNotifier, Restaurant?>(() {
  return RandomPickNotifier();
});

class RandomPickController {
  final Ref ref;
  RandomPickController(this.ref);

  void pickRandomRestaurant() async {
    // 1. 현재 목록 가져오기 (전체 카테고리)
    final restaurantsAsync = ref.read(nearbyRestaurantsProvider(null));

    restaurantsAsync.whenData((restaurants) {
      if (restaurants.isNotEmpty) {
        final random = Random();
        final picked = restaurants[random.nextInt(restaurants.length)];

        // 2. 상태 업데이트
        ref.read(randomPickProvider.notifier).setPickedRestaurant(picked);
      }
    });
  }
}

final randomPickControllerProvider = Provider((ref) => RandomPickController(ref));
