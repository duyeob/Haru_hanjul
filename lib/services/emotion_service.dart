import 'dart:convert';
import 'package:http/http.dart' as http;

class EmotionService {
  static const String _flaskEmotionUrl = 'http://localhost:5001/emotion'; // Flask 감정 분석 서버 주소

  static Future<String> analyzeEmotion(String text) async {
    final response = await http.post(
      Uri.parse(_flaskEmotionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['label'] != null) {
        return data['label']; // 예: 'positive', 'negative', 등
      }
      return '감정 분석 결과 없음';
    } else {
      return '감정 분석 실패: ${response.statusCode}';
    }
  }
}
