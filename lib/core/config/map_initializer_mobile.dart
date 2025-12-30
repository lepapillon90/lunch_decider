import 'package:flutter/foundation.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

Future<void> initializeMapPlatform() async {
  try {
    await NaverMapSdk.instance.initialize(
      clientId: 'vhx2yw8mqw',
      onAuthFailed: (ex) {
        debugPrint("********* 네이버맵 인증 실패: $ex *********");
      },
    );
  } catch (e) {
    debugPrint("Naver Map Init Failed: $e");
  }
}
