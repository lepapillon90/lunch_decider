import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

Widget getMapView(double latitude, double longitude, String restaurantName) {
  return _MobileMapView(latitude: latitude, longitude: longitude, restaurantName: restaurantName);
}

class _MobileMapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String restaurantName;

  const _MobileMapView({
    required this.latitude,
    required this.longitude,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(latitude, longitude),
          zoom: 16,
        ),
      ),
      onMapReady: (controller) {
        final marker = NMarker(
          id: 'target_restaurant',
          position: NLatLng(latitude, longitude),
          caption: NOverlayCaption(text: restaurantName),
        );
        controller.addOverlay(marker);
      },
    );
  }
}
