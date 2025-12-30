import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

Widget getMapView(double latitude, double longitude, String restaurantName) {
  return _MobileMapView(latitude: latitude, longitude: longitude, restaurantName: restaurantName);
}

class _MobileMapView extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String restaurantName;

  const _MobileMapView({
    required this.latitude,
    required this.longitude,
    required this.restaurantName,
  });

  @override
  State<_MobileMapView> createState() => _MobileMapViewState();
}

class _MobileMapViewState extends State<_MobileMapView> {
  KakaoMapController? mapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return KakaoMap(
      onMapCreated: ((controller) {
        mapController = controller;
        
        setState(() {
          markers.add(
            Marker(
              markerId: 'target_restaurant',
              latLng: LatLng(widget.latitude, widget.longitude),
            ),
          );
        });
      }),
      markers: markers.toList(),
      center: LatLng(widget.latitude, widget.longitude),
    );
  }
}
