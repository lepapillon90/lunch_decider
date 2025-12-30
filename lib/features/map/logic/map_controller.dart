import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MapController extends StateNotifier<int> {
  MapController() : super(0);

  Future<void> launchNavigation({
    required double lat,
    required double lng,
    required String name,
  }) async {
    // Naver Map URL Scheme
    final nmapUrl = Uri.parse(
      'nmap://route/public?dlat=$lat&dlng=$lng&dname=$name&appname=com.lunch_decider.app',
    );

    // Kakao Map URL Scheme
    final kakaoUrl = Uri.parse('kakaomap://route?ep=$lat,$lng&by=PUBLICTRANSIT');

    try {
      if (await canLaunchUrl(nmapUrl)) {
        await launchUrl(nmapUrl);
      } else if (await canLaunchUrl(kakaoUrl)) {
        await launchUrl(kakaoUrl);
      } else {
        // Fallback to web map or store page
        // For MVP, just print or show error (UI handling needed)
        print('No map app installed');
      }
    } catch (e) {
      print('Navigation launch error: $e');
    }
  }
}

final mapControllerProvider = StateNotifierProvider<MapController, int>((ref) => MapController());
