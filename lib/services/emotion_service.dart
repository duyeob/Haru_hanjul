import 'dart:convert';
import 'package:http/http.dart' as http;

class EmotionService {
  static const String _baseUrl = 'http://172.30.1.39:3000';

  static Future<String> analyzeEmotion(String text) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/emotion'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty && data[0]['label'] != null) {
        return data[0]['label'];
      }
      return '감정 결과 없음';
    } else {
      return '감정 실패: ${response.statusCode}';
    }
  }
}
