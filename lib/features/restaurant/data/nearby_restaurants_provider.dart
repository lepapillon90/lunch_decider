import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/location_provider.dart';
import '../domain/restaurant_model.dart';
import 'restaurant_provider.dart';

// 카테고리 상태 관리
class CategoryNotifier extends Notifier<String> {
  @override
  String build() => '전체';

  void setCategory(String category) {
    state = category;
  }
}

final selectedCategoryProvider = NotifierProvider<CategoryNotifier, String>(() {
  return CategoryNotifier();
});

final nearbyRestaurantsProvider = FutureProvider.family<List<Restaurant>, String?>((ref, category) async {
  // 1. 현재 위치 가져오기
  final position = await ref.watch(currentLocationProvider.future);
  
  // 2. Repository 가져오기
  final repository = ref.watch(restaurantRepositoryProvider);
  
  // 3. 위치 및 카테고리 기반 식당 검색
  return repository.getRestaurants(
    position.latitude, 
    position.longitude,
    category: category == '전체' ? null : category, // '전체'면 null 전달
  );
});
