import '../domain/restaurant_model.dart';
import '../domain/restaurant_repository.dart';

class MockRestaurantRepository implements RestaurantRepository {
  @override
  Future<List<Restaurant>> getRestaurants(double latitude, double longitude, {String? category}) async {
    // Simulate Network Delay
    await Future.delayed(const Duration(milliseconds: 800));

    final allRestaurants = [
      Restaurant(
        id: '1',
        name: '맛있는 김치찌개',
        category: '한식',
        distance: 150,
        address: '서울시 강남구 역삼동 123',
        latitude: 37.5006,
        longitude: 127.0365,
      ),
      Restaurant(
        id: '2',
        name: '홍콩반점',
        category: '중식',
        distance: 300,
        address: '서울시 강남구 역삼동 456',
        latitude: 37.5015,
        longitude: 127.0375,
      ),
      Restaurant(
        id: '3',
        name: '스시로',
        category: '일식',
        distance: 500,
        address: '서울시 강남구 삼성동 789',
        latitude: 37.5020,
        longitude: 127.0355,
      ),
      Restaurant(
        id: '4',
        name: '버거킹',
        category: '양식',
        distance: 50,
        address: '서울시 강남구 역삼동 100',
        latitude: 37.5000,
        longitude: 127.0360,
      ),
      Restaurant(
        id: '5',
        name: '스타벅스',
        category: '카페',
        distance: 10,
        address: '바로 앞',
        latitude: 37.5005,
        longitude: 127.0364,
      ),
    ];

    if (category != null) {
      return allRestaurants.where((r) => r.category == category).toList();
    }
    return allRestaurants;
  }
}
