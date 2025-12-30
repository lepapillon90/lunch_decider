import 'package:geolocator/geolocator.dart';

class LocationService {
  /// 현재 위치를 가져옵니다.
  /// 권한이 없거나 서비스가 꺼져있으면 에러를 반환합니다.
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. 위치 서비스 활성화 여부 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 서비스가 꺼져있으면 사용자에게 요청하거나 에러 처리
      return Future.error('Location services are disabled.');
    }

    // 2. 권한 확인
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 영구 거부된 경우 앱 설정으로 유도하거나 에러 처리
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // 3. 현재 위치 가져오기
    return await Geolocator.getCurrentPosition();
  }
}
