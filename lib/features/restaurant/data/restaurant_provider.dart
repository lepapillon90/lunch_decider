import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/restaurant_repository.dart';
import 'kakao_restaurant_repository.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  return KakaoRestaurantRepository();
});
