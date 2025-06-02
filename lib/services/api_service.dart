import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

  // 요약과 감정분석을 한번에 요청
  static Future<Map<String, String>> processDiary(String text) async {
    final url = Uri.parse('$baseUrl/summarize');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'summary': data['summary'] ?? '요약 정보 없음',
        'emotion': data['emotion'] ?? 'neutral',
      };
    } else {
      throw Exception('분석 실패: ${response.body}');
    }
  }
}
