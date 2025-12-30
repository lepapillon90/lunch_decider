import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

Widget getMapView(double latitude, double longitude, String restaurantName) {
  return _WebMapView(latitude: latitude, longitude: longitude, restaurantName: restaurantName);
}

class _WebMapView extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String restaurantName;

  const _WebMapView({
    required this.latitude,
    required this.longitude,
    required this.restaurantName,
  });

  @override
  State<_WebMapView> createState() => _WebMapViewState();
}

class _WebMapViewState extends State<_WebMapView> {
  late final String viewId;

  @override
  void initState() {
    super.initState();
    viewId = 'map-canvas-${DateTime.now().millisecondsSinceEpoch}';
    
    ui_web.platformViewRegistry.registerViewFactory(viewId, (_) {
      final div = html.DivElement()
        ..id = 'map-instance-$viewId'
        ..style.width = '100%'
        ..style.height = '100%';
      
      Future.delayed(const Duration(milliseconds: 500), () {
        js.context.callMethod('initNaverMap', ['map-instance-$viewId', widget.latitude, widget.longitude]);
      });
      
      return div;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: viewId);
  }
}
