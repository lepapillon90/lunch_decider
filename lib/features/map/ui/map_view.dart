import 'package:flutter/material.dart';

import 'map_view_mobile.dart' if (dart.library.html) 'map_view_web.dart';

class MapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String restaurantName;

  const MapView({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return getMapView(latitude, longitude, restaurantName);
  }
}
