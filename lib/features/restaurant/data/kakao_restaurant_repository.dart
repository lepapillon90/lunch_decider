import 'package:dio/dio.dart';
import '../domain/restaurant_model.dart';
import '../domain/restaurant_repository.dart';

class KakaoRestaurantRepository implements RestaurantRepository {
  final Dio _dio = Dio();
  final String _apiKey = '74df70df05ed21236b0347a28f5cee2a'; // Kakao REST API Key

  @override
  Future<List<Restaurant>> getRestaurants(double latitude, double longitude, {String? category}) async {
    try {
      final queryText = category != null ? '$category 맛집' : '맛집';
      
      final response = await _dio.get(
        'https://dapi.kakao.com/v2/local/search/keyword.json',
        queryParameters: {
          'query': queryText,
          'x': longitude.toString(),
          'y': latitude.toString(),
          'radius': 1000, // 1km 반경
          'sort': 'distance',
        },
        options: Options(
          headers: {
            'Authorization': 'KakaoAK $_apiKey', // REST API Key
          },
        ),
      );

      if (response.statusCode == 200) {
        final documents = response.data['documents'] as List;
        return documents.map((doc) {
          return Restaurant(
            id: doc['id'] ?? '',
            name: doc['place_name'] ?? '이름 없음',
            category: doc['category_name']?.split('>').last.trim() ?? '기타',
            imageUrl: '', // 이미지 API는 별도라 비워둠
            rating: 0.0, // 평점 데이터 없음
            distance: (double.tryParse(doc['distance'] ?? '0') ?? 0.0),
            address: doc['road_address_name'] ?? doc['address_name'] ?? '',
            latitude: double.tryParse(doc['y'] ?? '0') ?? 0.0,
            longitude: double.tryParse(doc['x'] ?? '0') ?? 0.0,
          );
        }).toList();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      print('Kakao API Error: $e');
      return []; // 에러 시 빈 리스트 반환 (또는 예외 발생)
    }
  }
}
