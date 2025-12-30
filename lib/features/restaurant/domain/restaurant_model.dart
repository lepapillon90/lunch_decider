class Restaurant {
  final String id;
  final String name;
  final String category; // 한식, 중식, 일식, 양식 등
  final double distance; // 미터(m) 단위
  final double rating;   // 0.0 ~ 5.0
  final String address;
  final String? phone;
  final String? imageUrl;
  final double latitude;
  final double longitude;

  Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.distance,
    this.rating = 0.0,
    required this.address,
    this.phone,
    this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['place_name'] ?? '',
      category: json['category_name']?.split('>').last.trim() ?? '기타',
      distance: double.tryParse(json['distance'] ?? '0') ?? 0.0,
      address: json['road_address_name'] ?? '',
      rating: 0.0, // API에서 제공하지 않을 경우 기본값
      latitude: double.tryParse(json['y'] ?? '0') ?? 0.0,
      longitude: double.tryParse(json['x'] ?? '0') ?? 0.0,
    );
  }
}
