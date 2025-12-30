import 'map_initializer_mobile.dart' if (dart.library.html) 'map_initializer_web.dart';

Future<void> initializeMap() => initializeMapPlatform();
