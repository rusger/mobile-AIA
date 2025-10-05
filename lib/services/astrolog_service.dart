import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class AstrologService {
  static const String _baseUrl = 'http://91.98.77.205/api';
  static const String _secretKey = 'cdc350a9383c659817d65e6fdab137a2fe9c750590e7e866ca0ae999a0ba5ce5';
  
  static Future<String?> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id ?? 'android-unknown';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'ios-unknown';
      }
    } catch (e) {
      print('Error getting device ID: $e');
    }
    return 'unknown-device';
  }
  
  static String _generateSignature(Map<String, dynamic> data) {
    // Sort keys to ensure consistent ordering
    final sortedData = Map.fromEntries(
      data.entries.toList()..sort((a, b) => a.key.compareTo(b.key))
    );
    final jsonStr = json.encode(sortedData);
    final bytes = utf8.encode(jsonStr);
    final key = utf8.encode(_secretKey);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);
    return digest.toString();
  }
  
  static Future<String?> calculateChart({
    required DateTime date,
    required String time,
    required double timezone,
    required double longitude,
    required double latitude,
  }) async {
    try {
      final deviceId = await _getDeviceId();
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      
      // Create data map for signature
      final data = {
        'date': '${date.month} ${date.day} ${date.year}',
        'time': time,
        'timezone': timezone.toString(),
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
        'device_id': deviceId,
        'timestamp': timestamp,
      };
      
      // Generate signature
      final signature = _generateSignature(data);
      
      // Add signature to data
      final requestData = Map<String, dynamic>.from(data);
      requestData['signature'] = signature;
      
      print('Sending request to: $_baseUrl/astrolog');
      print('Request data: ${json.encode(requestData)}');
      
      final response = await http.post(
        Uri.parse('$_baseUrl/astrolog'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      ).timeout(const Duration(seconds: 30));
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success'] == true) {
          return result['data'];
        } else {
          throw Exception(result['error'] ?? 'Unknown error');
        }
      } else if (response.statusCode == 429) {
        throw Exception('Please wait 10 seconds before requesting again');
      } else if (response.statusCode == 403) {
        throw Exception('Authentication failed');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Astrolog service error: $e');
      rethrow;
    }
  }
}