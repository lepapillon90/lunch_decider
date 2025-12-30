import 'restaurant_model.dart';
import '../../../../core/services/location_service.dart'; // For Position? Or clean entities?
// Using double latitude, double longitude for clean architecture dependency

abstract class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants(double latitude, double longitude, {String? category});
}
