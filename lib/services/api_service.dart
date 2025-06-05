import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

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
        'summary': data['summary'],
        'emotion': data['emotion'],
      };
    } else {
      throw Exception('분석 실패: ${response.body}');
    }
  }
}
