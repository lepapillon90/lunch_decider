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
      if (await canLaunchUrl(kakaoUrl)) {
        await launchUrl(kakaoUrl);
      } else if (await canLaunchUrl(nmapUrl)) {
        await launchUrl(nmapUrl);
      } else {
        final webUrl = Uri.parse('https://map.kakao.com/link/to/$name,$lat,$lng');
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Navigation launch error: $e');
    }
  }

  Future<void> launchDialer(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> launchUrlInBrowser(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

final mapControllerProvider = StateNotifierProvider<MapController, int>((ref) => MapController());
