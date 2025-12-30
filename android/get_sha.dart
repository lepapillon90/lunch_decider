
import 'dart:io';
import 'dart:convert';

void main() async {
  final file = File('signing_output.txt');
  if (await file.exists()) {
    // UTF-16LE reading is tricky in Dart standard library sometimes without exact decoder, 
    // but usually Windows files might just be readable as bytes or using correct codec.
    // Let's try reading as bytes and decoding manually if needed, or just standard readAsString 
    // if Dart detects it. Or try latin1/utf8 if it's not actually BOM'd correctly.
    // Wait, Powershell > creates UTF-16LE BOM.
    
    try {
      // Setup decoder logic if standard fails, but let's try standard first?
      // Actually, reading as bytes and decoding is safer if we know it's utf-16le.
      var bytes = await file.readAsBytes();
      // Remove BOM if present (FF FE)
      if (bytes.length >= 2 && bytes[0] == 0xFF && bytes[1] == 0xFE) {
        bytes = bytes.sublist(2);
      }
      
      // Decode: simplistic approach since mostly ASCII chars in SHA1 line
      // Or use string buffer.
      // Ideally usage of `Encoding.getByName('utf-16le')`? 
      // Dart doesn't have built-in utf-16le string decoder easily accessible in basic setup without package:chk? 
      // Actually, let's just use string parsing on the bytes -> string conversion.
      // Since it's LE, every second byte is 00 for ASCII.
      
      StringBuffer sb = StringBuffer();
      for (int i = 0; i < bytes.length; i += 2) {
        if (i + 1 < bytes.length) {
            // char code is byte[i] + (byte[i+1] << 8)
            int charCode = bytes[i] + (bytes[i+1] << 8);
            sb.writeCharCode(charCode);
        }
      }
      
      String content = sb.toString();
      List<String> lines = content.split('\n');
      for (var line in lines) {
        if (line.contains('SHA1:')) {
            String sha1 = line.trim().replaceAll('SHA1: ', '');
            List<String> parts = sha1.split(':');
            print('SHA1_Part1_ONLY: ${parts.sublist(0, 10).join(':')}');
        }
      }
      
    } catch (e) {
      print('Error: $e');
    }
  } else {
    print('File not found');
  }
}
