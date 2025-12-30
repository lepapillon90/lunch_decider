class Restaurant {
  final String id;
  final String name;
  final String category; // 한식, 중식, 일식, 양식 등
  final double distance; // 미터(m) 단위
  final double rating;   // 0.0 ~ 5.0
  final String address;
  final String? phone;
  final String? imageUrl;
  final String? placeUrl;
  final String? floor;
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
    this.placeUrl,
    this.floor,
    required this.latitude,
    required this.longitude,
  });



  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final address = json['road_address_name'] ?? json['address_name'] ?? '';
    
    // Extract floor from address if possible (e.g., "S빌딩 2층", "지하 1층")
    String? extractedFloor;
    final floorRegex = RegExp(r'((?:지하\s*)?\d+\s*층)|(?:[B\d]+층)', caseSensitive: false);
    final match = floorRegex.firstMatch(address);
    if (match != null) {
      extractedFloor = match.group(0);
    }

    return Restaurant(
      id: json['id'] ?? '',
      name: json['place_name'] ?? '',
      category: json['category_name']?.split('>').last.trim() ?? '기타',
      distance: double.tryParse(json['distance'] ?? '0') ?? 0.0,
      address: address,
      phone: json['phone'],
      placeUrl: json['place_url'],
      floor: extractedFloor,
      rating: 0.0,
      latitude: double.tryParse(json['y'] ?? '0') ?? 0.0,
      longitude: double.tryParse(json['x'] ?? '0') ?? 0.0,
    );
  }
}
