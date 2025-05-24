import 'dart:convert';
import 'package:http/http.dart' as http;

class SummaryService {
  static const String _baseUrl = 'http://localhost:3000';

  static Future<String> summarizeText(String text) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/summarize'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty && data[0]['summary_text'] != null) {
        return data[0]['summary_text'];
      }
      return '요약 결과 없음';
    } else {
      return '요약 실패: ${response.statusCode}';
    }
  }
}
