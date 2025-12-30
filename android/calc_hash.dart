
import 'dart:convert';
import 'dart:typed_data';

void main() {
  String sha1Hex = '66:CF:B3:1D:CB:AC:B9:1E:C7:75:AE:65:E3:F2:AC:C3:1D:24:E8:6E';
  List<String> parts = sha1Hex.split(':');
  List<int> bytes = parts.map((part) => int.parse(part, radix: 16)).toList();
  String base64Hash = base64.encode(bytes);
  print('Key Hash: $base64Hash');
}
