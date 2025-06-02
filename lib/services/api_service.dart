import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000'; // 서버 주소

  // 요약 + 감정분석 한꺼번에 요청
  static Future<Map<String, dynamic>> processDiary(String text) async {
    final url = Uri.parse('$baseUrl/summarize');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'summary': data['summary'],
        'emotion': data['emotion'],
        'emotion_score': data['emotion_score'],
      };
    } else {
      throw Exception('분석 실패: ${response.body}');
    }
  }
}
